/* JS Document */

/******************************
 
 [Table of Contents]
 
 1. Vars and Inits
 2. Set Header
 3. Init Menu
 4. Init Isotope
 5. Init Price Slider
 6. Init Products Height
 
 
 ******************************/

$(document).ready(function ()
{
    "use strict";

    /* 
     
     1. Vars and Inits
     
     */

    var header = $('.header');
    var menuActive = false;
    var menu = $('.menu');
    var burger = $('.burger_container');

    setHeader();

    $(window).on('resize', function ()
    {
        setHeader();
    });

    $(document).on('scroll', function ()
    {
        setHeader();
    });

    initMenu();
    initIsotope();
    initPriceSlider();
    initProductsHeight();

    /* 
     
     2. Set Header
     
     */

    function setHeader()
    {
        if ($(window).scrollTop() > 100)
        {
            header.addClass('scrolled');
        } else
        {
            header.removeClass('scrolled');
        }
    }

    /* 
     
     3. Init Menu
     
     */

    function initMenu()
    {
        if ($('.menu').length)
        {
            var menu = $('.menu');
            if ($('.burger_container').length)
            {
                burger.on('click', function ()
                {
                    if (menuActive)
                    {
                        closeMenu();
                    } else
                    {
                        openMenu();

                        $(document).one('click', function cls(e)
                        {
                            if ($(e.target).hasClass('menu_mm'))
                            {
                                $(document).one('click', cls);
                            } else
                            {
                                closeMenu();
                            }
                        });
                    }
                });
            }
        }
    }

    function openMenu()
    {
        menu.addClass('active');
        menuActive = true;
    }

    function closeMenu()
    {
        menu.removeClass('active');
        menuActive = false;
    }

    /* 
     
     4. Init Isotope
     
     */

    function initIsotope()
    {
        var sortingButtons = $('.product_sorting_btn');
        var sortNums = $('.num_sorting_btn');

        if ($('.product_grid').length)
        {
            var grid = $('.product_grid').isotope({
                itemSelector: '.product',
                layoutMode: 'fitRows',
                getSortData:
                        {
                            price: function (itemElement)
                            {
                                var priceEle = $(itemElement).find('.product_price').text().replace('$', '');
                                return parseFloat(priceEle);
                            },
                            name: '.product_name',
                            stars: function (itemElement)
                            {
                                var starsEle = $(itemElement).find('.rating');
                                var stars = starsEle.attr("data-rating");
                                return stars;
                            }
                        },
                animationOptions:
                        {
                            duration: 750,
                            easing: 'linear',
                            queue: false
                        }
            });

            // Sort based on the value from the sorting_type dropdown
            sortingButtons.each(function ()
            {
                $(this).on('click', function ()
                {
                    var parent = $(this).parent().parent().find('.sorting_text');
                    parent.text($(this).text());
                    var option = $(this).attr('data-isotope-option');
                    option = JSON.parse(option);
                    grid.isotope(option);
                });
            });

            // Change view to Box
            if ($('.box_view').length)
            {
                var box = $('.box_view');
                box.on('click', function ()
                {
                    if (window.innerWidth > 767)
                    {
                        $('.item').addClass('box');
                        var option = '{ "sortBy": "original-order" }';
                        option = JSON.parse(option);
                        grid.isotope(option);
                    }
                });
            }

            // Change view to List
            if ($('.detail_view').length)
            {
                var detail = $('.detail_view');
                detail.on('click', function ()
                {
                    if (window.innerWidth > 767)
                    {
                        $('.item').removeClass('box');
                        var option = '{ "sortBy": "original-order" }';
                        option = JSON.parse(option);
                        grid.isotope(option);
                        setTimeout(function ()
                        {
                            grid.isotope(option);
                        }, 500);
                    }
                });
            }

            // Show only a selected number of items
            sortNums.each(function ()
            {
                $(this).on('click', function ()
                {
                    var numSortingText = $(this).text();
                    var numFilter = ':nth-child(-n+' + numSortingText + ')';
                    $('.num_sorting_text').text($(this).text());
                    $('.product_grid').isotope({filter: numFilter});
                });
            });
        }
    }

    /* 
     
     5. Init Price Slider
     
     */


    /* 
     
     6. Init Products Height
     
     */

    function initProductsHeight()
    {
        if ($('.sidebar_left').length)
        {
            var sidebarH = $('.sidebar_left').outerHeight(true) + 309;
            $('.products').css('min-height', sidebarH);
        }
    }
});