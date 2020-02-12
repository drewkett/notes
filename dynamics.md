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

The solution is the same except that there are now multiple modes each
with an independent solution. Each mode has its own frequency and 
modeshape (the vector of displacements of each degree of freedom). The 
magnitude of a modeshape is not relevant. Whats important is the relative
displacement for each degree of freedom

Substituting the solution in gets you 

(-M&omega;<sup>2</sup> + K)\*u\*cos(&omega;t) = 0

If M and K are n x n matrices, there are n solutions to this problem. Each solution
&omega;<sub>i</sub> is a natural frequency of the system. Given a solution &omega;<sub>i</sub>, a corresponding eigenvector can be found by plugging in an eigenvalue and solving the system of equations for u. The collection of eigenvectors can be formed into a matrix (n vectors of length n). This eigenvector matrix &Phi; can be used to transform the solution between the physical domain and the modal domain. The eigenvectors are typically scaled such that modal mass equals 1

Subbing in x = &Phi;u and multiplying by &Phi;<sup>T</sup> we get

&Phi;<sup>T</sup>M&Phi;u'' + &Phi;<sup>T</sup>K&Phi;u  = 0

where 

&Phi;<sup>T</sup>M&Phi; = I

and

&Phi;<sup>T</sup>K&Phi; = &Omega;<sup>2</sup> where &Omega;<sup>2</sup> in this case is a diagonal matrix of eigenvalues

Looking at this, using the mapping x = &Phi;u, you can go between the modal domain and physical. 

The natural frequencies of a problem are useful for a couple of reasons. 

- If a natural frequency of a system is near an applied load frequency, you could see significant amplfication of motion. This can be analyzed by adding damping and a forcing function into the equations
- For a transient analysis of a problem, converting the problem to the modal domain and only taking modes in the frequency range of interest can significantly reduce the complexity of a problem which can greatly speed up analysis. Additionally, for transient analysis, the stability of a problem has to do with the highest eigenvalues of a particular problem. Higher eigenvalues lead to either needing a smaller time step or adding artificial damping either explicitly using a damping term or implicitly using an implicit solver.