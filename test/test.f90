program test

  use iso_fortran_env, only: dp => real64
  use statistics
  implicit none

  real(dp) :: r(1000)

  call random_number(r)

  print*, avr(r), std_err(r),jackknife(r,20)

end program test
