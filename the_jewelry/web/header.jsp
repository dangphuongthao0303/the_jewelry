<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wish</title>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetch('/category')
                .then(response => response.json())
                .then(data => {
                    const categoriesList = data.categories;
                    const navList = document.querySelector('.main_nav ul');

                    categoriesList.forEach(category => {
                        const li = document.createElement('li');
                        const a = document.createElement('a');
                        a.href = `categories.html?category=${category.categoryId}`; // Assuming `categoryId` is the ID of the category
                        a.textContent = category.categoryName; // Use category name as the link text
                        li.appendChild(a);
                        navList.appendChild(li);
                    });
                })
                .catch(error => {
                    console.error('Error fetching categories:', error);
                });
        });
    </script>
</head>
<body>
    <header class="header">
        <div class="header_inner d-flex flex-row align-items-center justify-content-start">
            <div class="logo"><a href="#">Wish</a></div>
            <nav class="main_nav">
                <ul>
                    <li><a href="#">home</a></li>
                    <!-- Categories will be dynamically loaded here -->
                    <li><a href="contact.html">contact</a></li>
                </ul>
            </nav>
            <div class="header_content ml-auto">
                <div class="search header_search">
                    <form action="#">
                        <input type="search" class="search_input" required="required">
                        <button type="submit" id="search_button" class="search_button"><img src="images/magnifying-glass.svg" alt=""></button>
                    </form>
                </div>
                <div class="shopping">
                    <!-- Cart -->
                    <a href="#">
                        <div class="cart">
                            <img src="images/shopping-bag.svg" alt="">
                            <div class="cart_num_container">
                                <div class="cart_num_inner">
                                    <div class="cart_num">1</div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Star -->
                    <a href="#">
                        <div class="star">
                            <img src="images/star.svg" alt="">
                            <div class="star_num_container">
                                <div class="star_num_inner">
                                    <div class="star_num">0</div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Avatar -->
                    <a href="#">
                        <div class="avatar">
                            <img src="images/avatar.svg" alt="">
                        </div>
                    </a>
                </div>
            </div>

            <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm">
                <div></div><div></div><div></div>
            </div>
        </div>
    </header>
</body>
</html>
