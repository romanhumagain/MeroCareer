import React from "react";

const Footer = () => {
  return (
    <footer className="py-8 text-white bg-slate-900">
      <div className="container px-4 mx-auto">
        <div className="grid grid-cols-1 gap-8 md:grid-cols-3">
          <div>
            <h4 className="mb-4 text-lg font-bold">About MeroCareer</h4>
            <p className="text-sm text-gray-300">
              MeroCareer is your trusted platform for finding jobs and hiring top talent. We bridge the gap between job seekers and recruiters.
            </p>
          </div>


          <div>
            <h4 className="mb-4 text-lg font-bold">Quick Links</h4>
            <ul className="space-y-2">
              <li>
                <a  className="text-gray-300 hover:text-white">
                  Jobs
                </a>
              </li>
              <li>
                <a className="text-gray-300 hover:text-white">
                  About Us
                </a>
              </li>
              <li>
                <a  className="text-gray-300 hover:text-white">
                  Contact
                </a>
              </li>
              <li>
                <a className="text-gray-300 hover:text-white">
                  Terms & Conditions
                </a>
              </li>
            </ul>
          </div>

         
          <div>
            <h4 className="mb-4 text-lg font-bold">Connect with Us</h4>
            <div className="flex space-x-4">
              <a
              
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-300 hover:text-white"
              >
                <i className="fab fa-facebook-f"></i> Facebook
              </a>
              <a
               
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-300 hover:text-white"
              >
                <i className="fab fa-twitter"></i> Twitter
              </a>
              <a
               
                target="_blank"
                rel="noopener noreferrer"
                className="text-gray-300 hover:text-white"
              >
                <i className="fab fa-linkedin"></i> LinkedIn
              </a>
            </div>
          </div>
        </div>

        
        <div className="my-6 border-t border-gray-600"></div>


        <div className="flex items-center justify-between px-4 text-sm text-gray-400">
          <p>&copy; 2024 MeroCareer. All Rights Reserved.</p>
          <p>
            Made with ❤️ in <span className="font-bold">Nepal</span>.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
