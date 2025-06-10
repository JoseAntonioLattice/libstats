module statistics

  use iso_fortran_env, only : dp => real64, i4 => int32
  implicit none
  
contains

  function avr(x)
    real(dp) :: avr
    real(dp), intent(in) :: x(:)

    avr = sum(x)/size(x)

  end function avr

  function var(x)
    real(dp) :: var
    real(dp), intent(in) :: x(:)

    var = sum((x-avr(x))**2)/(size(x)-1)

  end function var


  function std_err(x)
    real(dp) :: std_Err
    real(dp), intent(in) :: x(:)

    std_Err = sqrt(var(x)/size(x))

  end function std_err


end module statistics
