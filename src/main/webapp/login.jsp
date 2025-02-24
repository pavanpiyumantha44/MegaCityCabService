<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.15/tailwind.min.css">
</head>
<body>
  <section class="flex flex-col md:flex-row h-screen items-center">

    <div class="bg-blue-600 hidden lg:block w-full md:w-1/2 xl:w-2/3 h-screen">
      <img src="https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" alt="" class="w-full h-full object-cover">
    </div>

    <div class="bg-white w-full md:max-w-md lg:max-w-full md:mx-auto md:mx-0 md:w-1/2 xl:w-1/3 h-screen px-6 lg:px-16 xl:px-12
          flex items-center justify-center">

      <div class="w-full h-100">
        <div class="w-full text-center">
            <h1 class="text-xl font-bold mt-12">
                <span class="text-red-500">Mega</span>
                <span class="text-blue-500">City</span>
                Cab Service
            </h1>
        </div>

          <div class="shadow-lg p-5 rounded-lg bg-white my-5 mt-12">
            <h1 class="text-xl md:text-2xl font-bold leading-tight text-center">Log in</h1>
            <p class="text-center mt-2" id="loginMsg"></p>
            <form action="auth?action=login" method="post">
            <div>
                <label class="block text-gray-700">Email Address</label>
                <input type="email" name="email" id="email" placeholder="Enter Email Address" class="w-full px-4 py-3 rounded-lg bg-gray-200 mt-2 border focus:border-blue-500 focus:bg-white focus:outline-none" autofocus autocomplete required>
            </div>

            <div class="mt-4">
                <label class="block text-gray-700">Password</label>
                <input type="password" name="password" id="password" placeholder="Enter Password" minlength="6" class="w-full px-4 py-3 rounded-lg bg-gray-200 mt-2 border focus:border-blue-500
                    focus:bg-white focus:outline-none" required>
            </div>

            <div class="text-right mt-2">
                <a href="#" class="text-sm font-semibold text-gray-700 hover:text-blue-700 focus:text-blue-700">Forgot Password?</a>
            </div>

            <button type="submit" class="w-full block bg-blue-500 hover:bg-blue-400 focus:bg-blue-400 text-white font-semibold rounded-lg px-4 py-3 mt-6">Log In</button>
            </form>
            <div class="d-flex text-center my-3">
            <a href="register.jsp" class="text-blue-500 underline">Don't have an account?</a>
            </div>
        </div>
      </div>

    </div>

  </section>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>