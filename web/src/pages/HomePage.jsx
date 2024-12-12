// src/pages/Home.jsx
import React from "react";
import app_logo from '../assets/app_logo.png'
import { Link } from "react-router-dom";

const Home = () => {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-300">
      <div className="text-center mb-14">
        <div className="flex items-center justify-center">
          <img src={app_logo} alt="" height={100} width={100} />
        </div>
        <h1 className="mb-4 text-4xl font-bold text-blue-600">MeroCareer</h1>
        <p className="mb-6 text-lg text-gray-700">Our app is currently under construction.</p>
        <p className="text-gray-600">
          We’re working hard to bring you an amazing experience. Stay tuned for updates!
        </p>
      </div>
    </div>
  );
};

export default Home;
