//Register a service Worker
document.addEventListener('DOMContentLoaded', registerServiceWorker => {
    const loginBtn = document.querySelector('#login');
    const signupBtn = document.querySelector('#signup');

    const loader = document.querySelector('#loader');

    loginBtn.addEventListener('click', () => {
        loader.style.display = "flex";
        const randomTime = Math.random() * 5 * 1000; // Random number between 1 and 5
        setTimeout(() => {
            loader.style.display = "none";
            window.location.assign('./login.html')
        }, randomTime);
    })

    signupBtn.addEventListener('click', () => {
        loader.style.display = "flex";
        const randomTime = Math.random() * 5 * 1000; // Random number between 1 and 5
        setTimeout(() => {
            loader.style.display = "none";
            window.location.assign('./signup.html')
        }, randomTime);
    })
});
