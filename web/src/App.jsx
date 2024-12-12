import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./components/NavBar";
import Home from "./pages/HomePage";
import ForgotPassword from "./pages/ForgotPassword"; // Ensure this component exists
import Footer from "./components/Footer";

function App() {
  return (
    <>
      <Router>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/forgot-password/:token" element={<ForgotPassword />} />
        </Routes>
        <Footer/>
      </Router>
    </>
  );
}

export default App;
