# Finite Element Analysis

## Transforming the Problem

Everything that isn't a typical element with stiffness can be thought of as a
transformation matrix mapping the nodes from the model to a reduced set of
degrees of freedom to be solved. In NASTRAN, this includes RBE2's, RBE3's, MPC's
and SPC's. A typical formulation for transforming a problem is as follows.

This is a basic statics problem. `K` is the stiffness matrix. `u` is the
displacement vector and `F` is the applied force

    K*u = F

A transformation matrix is anything that maps `u` to a new vector space. This
would follow the following format where `T` is the tranformation matrix and `v`
is the new displacement vector (it can be the same length or smaller than `u`)

    u = T*v

A transformation matrix could be done the other way such that `T*u = v`, but
that format is not condusive to manipuling the initial problem. Given this
transformation matrix, we can subsitute `T*v` for `u` in the inital problem.

    K*T*v = F

Premultiplying both sides by `T'` where `'` represents the transpose, gets us to

    T'*K*T*v = T'*F

This is essential to make the problem solvable. If `u` has `n` dof's and `v` as
`m` dof's then `T` is an `n` x `m` matrix. `K*T` would also be and `n` x `m`
matrix which can't be inverted. Premultiplying by `T'`, makes the matrix
`T'*K*T` an `m` x `m` matrix. Solving this we would get

    v = (T'*K*T)^-1*T'*F

This is the solution for `v`. But we typically don't care what `v` is directly
since it is a transformation of our original degrees of freedom. However we can
then solve for `u` by sustituting `v` back into the original transformation
`u = T*v`

    u = T*v

The concept behind this method can be used to implement `SPC`s, `MPC`s, `RBE2`s,
`RBE3`s in NASTRAN. (Its not necessarily how its done in practice since there
are some shortcuts that can be done for implementing some of them, rather than
building a complete transformation matrix).

Typically you would only have constraints from those elements on a small part of
the model. If you want to apply this technique this way you need a complete
transformation matrix that maps every dof from the model to the reduced dof set.
This is done by basically adding an identity matrix for every dof that is left
unchanged, basically saying that each of those dof's from the model is equal to
a dof in the reduced set.

This technique can be applied successively. As in multiple transformations can
be done. Though the second applied transformation must take the transformed
variables from the first transformation as its input. If this is not the case,
you should try to merge the two sets of constraints from the transformation
matrix. This is doable if the constraints don't affect the same degrees of
freedom. (Alternatively you may be able to solve for a new transformation matrix
but I'm not 100% this can always be done)

## Nastran SPC

A transformation matrix for an `SPC` would be a row of all zeros in the
transformation matrix which zeros out the effect of the degree of freedom being
eliminated (with an identity matrix for all the other nodes).

## Nastran MPC

An `MPC` is a constraint equation. This would be done by a solving the equation
for one of the dof's inputting it into the transformation matrix. (It doesn't
matter which degree of freedom you solve for since once the problem is solved in
the reduced dof set then it gets mapped back to the original problem domain).

## Nastran RBE2

An `RBE2` is effectively an `MPC` as well. The constraint equations just gets
determined by NASTRAN based on the nodes used and the geometry of the problem. A
separate constraint equation is determined each dependent degree of freedom.

## Nastran RBE3

An RBE3 is used to attach a single dependent node to multiple independent nodes.
Similar to an RBE2, it gets mapped to constraint equations based on the nodes
used and the geometry of the problem. Unlike the RBE2 though, it can be used in
an overdetermined manner. It becomes overdetermined when the number of
independent degrees of freedom is greater than the number of dependant ones. In
that case it solves for a transformation matrix using a least squares approach.
This can lead to unexpected resuls, which it is generally advised to be very
careful with RBE3's.

### Example

Lets say you have the following problem. (The `1246` at the end of the grid
definition says to constrain the `1`,`2`,`4` and `6` dof of the nodes. This is
done to reduce the number of dof's for the sake of simplifying the example)

    GRID    1      0      0.      0.      0.              1246
    GRID    2      0      2.      0.      0.              1246
    GRID    3      0      4.      0.      0.              1246
    RBE3    1             2      35       1.      1       1
    +       3

The three nodes are in a line separated by 2 length unitt each. The RBE3
connects the `3` and `5` degrees of freemdom of the node in the middle (`2`) to
the `3` degree of freedom of the other two nodes. To determine the constraint
equation an intermediate matrix must be created. In this case `i` will represent
the independent dof's, `d` the dependent and `A` represents the initial set of
equations mapping from one to the other. (The annotation used for the
displacements is `u_jk` where `j` is the grid id and `k` is the dof)

    i = A*d

    i = [[u_13 u_33]]
    d = [[u_23 u_25]]

    A = [[1 2], [1 -2]]

In this case we are saying there are two basic equations to satisfy

    u_13 = u_23 + 2*u_25

and

    u_33 = u_23 - 2*u_25

The factor of 2 comes from the distance between the nodes. (I'm not 100% if this
is the right way to interpret the meaning of these equations, but it seems to
work for creating the transformation matrix `T` that we would like to transform
the problem.) The format of the transformation matrix is inverted compared to
the current system of equations in that the transformation matrix `T` is
multiplied by the reduced set of dof, which in our case would exclude `u_23` and
`u_25`. In this example it can be transformed by just directly inverting the `A`
matrix which gives us.

    A^-1 = [[0.5 0.5] [0.25 -0.25]]

Turning this into constraint equations we get

    u_23 = 0.5 * u_13 + 0.5 * u_33
    u_25 = 0.25 * u_13 - 0.25 * u_33

So the displacement in the `3` dof is equal to the average of that of the
independent nodes. And the rotation dof `5` is a quarter of the different
between the displacements

These constraint equations can now be plugged into a `T` matrix that can be used
to solve the problem

    u = [[u_13 u_15 u_23 u_25 u_33 u_35]]
    v = [[u_13 u_15 u_33 u_35]]

    T = [[1 0 0 0] [0 1 0 0] [0.5 0 0.5 0] [0.25 0 -0.25 0] [0 0 1 0] [0 0 0 1]]

    u = T*v

Using this formulation, we have a tranformation matrix in the format described
above that could be used solve the problem. (This example doesn't have any
stiffness or force so there is nothing to solve)

If we added a 4th node to the problem located at (6,0,0) and included it as an
independent degree of freedom. Our new `A` Matrix would be

    i = [[u_13 u_33 u_43]]
    d = [[u_23 u_25]]

    A = [[1 2] [1 -2] [1 -4]]

    i = A*d

This is no longer a square matrix so we can't solve it directly for d. To solve
this using the least squares approach, we would first premultiply by `A'` and
then invert `A'*A` like so

    A'*i = A'*A*d
    (A'*A)^-1*A'*i = (A'*A)^-1*(A'*A)*d = I*d
    d = (A'*A)^-1*A'*i

The result of that transformation for our problem is

    (A'*A)^-1*A' = [[0.571 0.286 0.143] [0.179 -0.036 -0.143]]

or as constraint equations

    u_23 = 0.571*u_13 + 0.286*u_33 + 0.143*u_43
    u_25 = 0.179*u_13 - 0.036*u_33 - 0.143*u_43

There is nothing obvious about the solution and its correctness, which I guess
could be used to show that there isn't always intuition about what an RBE3 is
doing. This is obviously a contrived example that you would likely never see in
practice, but if you don't have an intuition about how it is applied, you
probably shouldn't be using an RBE3.

TODO Consider adding longer discussion on why overdetermined RBE3's can cause
lots of problems

### Weighting factors

The weighting factors in the RBE3 can be a way of modifying the distribution of
the load through the RBE3. If we take the basic setup of the problem above but
multiple the problem by a new matrix `W` which is a diagonal square matrix with
the weighting factors of the independent dof's on the diagonal, we get

    W*i = W*A*d

Since `W` is a square matrix the dimensions of the problem don't change. We now
solve for `d` like we did before

    (W*A)'*W*i = (W*A)'*(W*A)*d
    d = ((W*A)'*(W*A))^-1*(W*A)*W*i

This new transformation `((W*A)'*(W*A))^-1*(W*A)*W` can be calculated and turned
into constraint equations. I know it doesn't seem like this method would work
but it does, sort of. Mathematically it works and produces a result that is
consistent for finite element analysis. Physically though, it can have very
unexpected results. RBE3's can be confusing enough, the effects of weighting
factors actually manage to make the effect of RBE3's even more confusing. Buyer
Beware.

Note, when the number of dependent degrees of freedom match the the number of
independent degrees of freedom, it is a statically determined solution in which
case the weighting factors don't make a difference.
