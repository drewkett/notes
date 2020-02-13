# Single Degree of Freedom

An undamped single degree of freedom system can be represented as

mx'' + kx = 0

The solution to this system is

x = cos(&omega;t)

Substituting

(-m*&omega;<sup>2</sup> + k)*cos(&omega;t) = 0

Solving for &omega;

&omega; = sqrt(k/m)

The units would be in radians/s

# Multi Degree of Freedom

This can be expanded to matrices

Mx'' + Kx = 0

The solution is the same except that there are now multiple modes each with an
independent solution. Each mode has its own frequency and modeshape (the vector
of displacements of each degree of freedom). The magnitude of a modeshape is not
relevant. Whats important is the relative displacement for each degree of
freedom

Substituting the solution in gets you

(-M&omega;<sup>2</sup> + K)\*u\*cos(&omega;t) = 0

If M and K are n x n matrices, there are n solutions to this problem. Each
solution &omega;<sub>i</sub> is a natural frequency of the system. Given a
solution &omega;<sub>i</sub>, a corresponding eigenvector can be found by
plugging in an eigenvalue and solving the system of equations for u. The
collection of eigenvectors can be formed into a matrix (n vectors of length n).
This eigenvector matrix &Phi; can be used to transform the solution between the
physical domain and the modal domain. The eigenvectors are typically scaled such
that modal mass equals 1

Subbing in x = &Phi;u and multiplying by &Phi;<sup>T</sup> we get

&Phi;<sup>T</sup>M&Phi;u'' + &Phi;<sup>T</sup>K&Phi;u = 0

where

&Phi;<sup>T</sup>M&Phi; = I

and

&Phi;<sup>T</sup>K&Phi; = &Omega;<sup>2</sup> where &Omega;<sup>2</sup> in this
case is a diagonal matrix of eigenvalues

Looking at this, using the mapping x = &Phi;u, you can go between the modal
domain and physical.

The natural frequencies of a problem are useful for a couple of reasons.

- If a natural frequency of a system is near an applied load frequency, you
  could see significant amplfication of motion. This can be analyzed by adding
  damping and a forcing function into the equations
- For a transient analysis of a problem, converting the problem to the modal
  domain and only taking modes in the frequency range of interest can
  significantly reduce the complexity of a problem which can greatly speed up
  analysis. Additionally, for transient analysis, the stability of a problem has
  to do with the highest eigenvalues of a particular problem. Higher eigenvalues
  lead to either needing a smaller time step or adding artificial damping either
  explicitly using a damping term or implicitly using an implicit solver.

# Modal Sensitivity

In a multi degree of freedom system, its sometimes important to determine what
the main contributor is to a particular mode. This information can be used if
the frequency of the mode needs to be changed for operation requirements or in
tuning a model to test data its useful to know which part of the model to
change. Often identifying the critical component to a mode isn't difficult to
identify, but it can be when it is a combination of multiple modes.

There are two ways to identify modal element contribution using a model.

- Check the strain energy for a given mode. This is an easy output to add for
  NASTRAN (`ESE = ALL` in case control) and can show which elements in the model
  are the biggest contributors for a given mode. It can be looked at in two
  ways: Strain Energy and Strain Energy Density. Both of these can be useful for
  different things.

  - Strain Energy Density is useful to identify areas that have more strain than
    other areas. Though if its just a small section of the model, even if that
    section gets stiffened greatly, its unlikely to have a signficant effect on
    the mode and its frequency.
  - Strain Energy can be used to identify where all the strain energy is for a
    given mode. This can also be viewed as percent strain energy. It can be
    useful to sum up strain energy for multiple adjacent elements or types of
    elements to see the percent strain energy for a particular section of the
    model. What you're looking for when trying to adjust a model to match
    something is the property that you can change that has the biggest effect on
    the mode that you want to change without significantly affecting other modes
    that you think are correct

- The other option requires a bit of scripting, but is very effective once you
  have it set up. If you apply a small increase across the whole stiffness
  matrix, you would get a small increase in all the modal frequencies. The
  increase can be estimated by doing a first order taylor series expansion of
  &Omega;<sup>2</sup>. If you do that what you get is that for 1% increase in
  stiffness, you would expect a 0.5% in a modal frequency. (This would break
  down at higher increases in stiffness but it is a good approximation for small
  increases in stiffness). If we take that idea, and apply a 1% increase in
  stiffness to an individual component (or sets of components) of a model and
  run the resulting model we can compare the change in natural frequencies to
  estimate the contribution of that component.

  TODO This requires more explanation
