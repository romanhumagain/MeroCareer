import React, { useState, useEffect } from 'react'
import { IoLogIn } from "react-icons/io5";
import { useParams } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Toastify from '../components/Toastify';
import MeroCarrerLogo from '../assets/app_logo.png';
import { useNavigate } from 'react-router-dom';
import LoadingModal from '../components/LoadingModal';
import { IoEye, IoEyeOff } from "react-icons/io5";

const ForgotPassword = () => {
  const [isTokenVerified, setIsTokenVerified] = useState(true)
  const [loading, setLoading] = useState(true)
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const { token } = useParams()
  const navigate = useNavigate()

  const form = useForm({
    defaultValues: {
      password: "",
      confirm_password: ""
    }
  })
  const { register, formState, handleSubmit, reset, getValues } = form;
  const { errors, } = formState

  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const toggleConfirmPasswordVisibility = () => {
    setShowConfirmPassword(!showConfirmPassword);
  };

  

  
  const show_toastify = (message, type) => {
    Toastify(message, type)

  }
  const handlePasswordReset = async (data) => {
    data['token'] = token;
  
    try {
      setLoading(true);
  
      const response = await fetch('http://127.0.0.1:8000/api/confirm-password-reset/', {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });
  
      console.log(response)
      if (response.ok) {
        show_toastify("Successfully changed your password! \n You can login now!", "success");
        // reset();
        
      } else {
        const errorData = await response.json();
    
        if (response.status === 400) {
          show_toastify("Token already expired. Please resend new token!", "error");
        } else if (response.status === 404) {
          show_toastify("Token Doesn't Exist!", "error");
        } else {
          console.error("Unhandled error:", errorData);
        }
      }
    } catch (error) {
      console.error("Error resetting password:", error);

    } finally {
      setLoading(false);
    }
  };
  

  const verifyPasswordResetToken = async () => {
    try {
      const response = await fetch(`http://127.0.0.1:8000/api/verify-password-reset-token/${token}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });
  
      if (response.ok) {
        setIsTokenVerified(true);
      } else {
        setIsTokenVerified(false);
        show_toastify("Token verification failed. It might have expired!", "error");
      }
    } catch (error) {
      console.error("Error verifying token:", error);
      setIsTokenVerified(false);
      show_toastify("Network error while verifying token. Please try again later.", "error");
    } finally {
      setLoading(false);
    }
  };
  
  useEffect(() => {
    verifyPasswordResetToken()
  }, [token])


  if (!isTokenVerified) {
    return (
      <>
        <div className='flex items-center justify-center h-screen mb-3 bg-gray-300'>
          <div className='mb-24 text-center'>
            <p className='text-[70px] font-bold text-gray-600'>404 Error</p>
            <p className='text-2xl text-gray-600'>Token Expired !</p>
          </div>
        </div>

      </>
    )
  }

  return (
    <>
      {loading && (
        <LoadingModal isOpen={true} />
      )}
      <div className='flex w-full h-screen py-10 transition-all duration-300 pb-30 bg-slate-300 '>
        <div className='h-[85%] p-1 pb-10 bg-gray-300 max-w-[390px] w-full  rounded-lg shadow-lg mx-auto dark:bg-neutral-800 '>
          <div className="flex justify-center text-center">
            <img src={MeroCarrerLogo} alt="" height={60} width={60} />
          </div>
          <div className="mt-2 mb-6 text-lg font-semibold text-center text-gray-500 duration-150 dark:text-gray-300">
            Reset password for MeroCareer account
          </div>
          <div className='m-5'>
            <p className='m-4 font-normal text-center text-gray-500 text-md dark:text-gray-400'>Enter a new password for your account. Ensure it's strong and secure.</p>
          </div>
          <div className='m-5 mt-10'>
          <form onSubmit={handleSubmit(handlePasswordReset)}>
              <div className="m-4 mb-6">
                <label className="block mb-2 text-sm font-bold text-gray-700 dark:text-gray-100" htmlFor="password">
                  New Password
                </label>
                <div className="relative">
                  <input
                    className="w-full px-3 py-2 text-gray-700 border shadow appearance-none rounded-xl focus:outline-none focus:shadow-outline focus:ring-2 focus:ring-slate-400 dark:focus:ring-gray-500"
                    id="password"
                    type={showPassword ? "text" : "password"}
                    placeholder="New Password"
                    {...register("password", {
                      required: "Please enter a new password!",
                      validate: {
                        passwordLength: (value) =>
                          value.length >= 8 || "Password should be at least 8 characters long!",
                      },
                    })}
                  />
                  <span
                    className="absolute inset-y-0 flex items-center text-gray-500 cursor-pointer right-3 dark:text-gray-300"
                    onClick={togglePasswordVisibility}
                  >
                    {showPassword ? <IoEyeOff /> : <IoEye />}
                  </span>
                </div>
                <p className="mt-1 text-sm text-red-500">{errors.password?.message}</p>
              </div>

              <div className="m-4 mb-6">
                <label className="block mb-2 text-sm font-bold text-gray-700 dark:text-gray-100" htmlFor="confirm_password">
                  Confirm Password
                </label>
                <div className="relative">
                  <input
                    className="w-full px-3 py-2 text-gray-700 border shadow appearance-none rounded-xl focus:outline-none focus:shadow-outline focus:ring-2 focus:ring-slate-400 dark:focus:ring-gray-500"
                    id="confirm_password"
                    type={showConfirmPassword ? "text" : "password"}
                    placeholder="Confirm Password"
                    {...register("confirm_password", {
                      required: "Please confirm your password!",
                      validate: {
                        passwordMatch: (value) =>
                          value === getValues("password") || "Passwords do not match!",
                      },
                    })}
                  />
                  <span
                    className="absolute inset-y-0 flex items-center text-gray-500 cursor-pointer right-3 dark:text-gray-300"
                    onClick={toggleConfirmPasswordVisibility}
                  >
                    {showConfirmPassword ? <IoEyeOff /> : <IoEye />}
                  </span>
                </div>
                <p className="mt-1 text-sm text-red-500">{errors.confirm_password?.message}</p>
              </div>

              <div className="m-3 my-10 mb-4">
                <button
                  type="submit"
                  className="w-full p-2 text-sm font-semibold text-white bg-blue-500 hover:bg-blue-600 rounded-xl dark:bg-blue-600 dark:hover:bg-blue-700"
                >
                  <IoLogIn className="inline mr-1 text-xl" /> Change Password
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <ToastContainer />
    </>
  )
}

export default ForgotPassword