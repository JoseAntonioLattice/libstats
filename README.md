# Instructions

- Clone the repository to your computer.
- Open a terminal in the directory of the library and type "make"
- If you want to run the test to see if the library is properly installed type in the terminal "make run_test"

- Use the library by writing "use statistics" in your code before the "implicit none"
- Compile your program and use the library "-lstats" and use the library path "-L $HOME/Fortran/lib"


# statistics Module Documentation

This Fortran module provides basic statistical functions for analyzing numerical data using double precision. The main features include mean, variance, standard error, and jackknife resampling techniques.

## Dependencies

```
use iso_fortran_env, only : dp => real64, i4 => int32
```

- `dp`: Alias for double precision (`real64`).
- `i4`: Alias for 32-bit integer (`int32`).

## Functions

### avr(x)

**Description**:\
Calculates the arithmetic mean (average) of a real-valued array.

**Interface**:

```
real(dp) function avr(x)
real(dp), intent(in) :: x(:)
```

**Returns**:

- The mean of the input array `x`.

---

### var(x)

**Description**:\
Computes the **sample variance** of the input array.

**Interface**:

```
real(dp) function var(x)
real(dp), intent(in) :: x(:)
```

**Returns**:

- The unbiased sample variance:\
  $$\text{var}(x) = \frac{1}{N - 1} \sum_i (x_i - \langle x \rangle)^2$$

---

### std\_err(x)

**Description**:\
Computes the **standard error** of the mean.

**Interface**:

```
real(dp) function std_err(x)
real(dp), intent(in) :: x(:)
```

**Returns**:

- The standard error:\
  $$ \text{std\_err} = \sqrt{\frac{\text{var}(x)}{N}}$$

---

### jackknife(x, bins)

**Description**:\
Calculates the **jackknife error estimate** by partitioning the dataset into a number of `bins`.

**Interface**:

```
real(dp) function jackknife(x, bins)
real(dp), intent(in) :: x(:)
integer(i4), intent(in) :: bins
```

**Details**:

- Splits the array into `bins` equal-sized segments.
- Performs jackknife resampling by systematically leaving out each bin and computing the mean.
- Returns the standard deviation of these means as an error estimate.

**Returns**:

- Jackknife estimate of the standard error:

$$
\text{jackknife}(x) = \sqrt{\frac{B - 1}{B} \sum_{i=1}^{B} (\bar{x}_{(i)} - \bar{x})^2}
$$

Where:

- $B$ is the number of bins.
- $\bar{x}_{(i)}$ is the mean with the $i$-th bin removed.
- $\bar{x}$ is the overall mean.

---

### jackknife\_max(x)

**Description**:\
Finds the **maximum jackknife error** among all valid bin counts (i.e., divisors of the array size), and the number of bins that produces it.

**Interface**:

```
real(dp) function jackknife_max(x)
real(dp), intent(in) :: x(:)
```

**Returns**:

- A real array of size 2:
  1. Maximum jackknife error.
  2. Number of bins that yielded that maximum error.

---

## Notes

- Assumes the input array `x` has a size divisible by the number of bins in `jackknife`.
- The code ignores bin counts that do not evenly divide the dataset length in `jackknife_max`.

