//
//  Restaurant.swift
//  PickABite
//
//  Created by Dimaseditiya on 19/05/25.
//

import Foundation
import SwiftUI

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let thumbnail: String
    let description: String
    
    static func filterRestaurants(byName name: String) -> [Restaurant] {
            return allRestaurants.filter { $0.name.localizedCaseInsensitiveContains(name) }
    }
    
    static let allRestaurants: [Restaurant] = [
        Restaurant(
            name: "Arabica",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/11/Arabica-01.jpg",
            description: "% Arabica is about my love for coffee, design, and seeing the world. My story begins in Tokyo, Japan. Being raised by parents who were enthusiasts of a universal language called 'Esperanto', we would travel abroad every summer to attend a 'World Esperanto Congress' held in different countries."
        ),
        Restaurant(
            name: "AUNTIE ANNE'S",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/AUNTIE-ANNES.jpg",
            description: "Auntie Anne's is an American franchised chain of pretzel shops founded by Anne F. Beiler and her husband, Jonas, in 1988. Auntie Anne's serves products such as pretzels, dips, and beverages."
        ),
        Restaurant(
            name: "Bebek Bengil",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BEBEK-BENGIL-1.jpg",
            description: "BEBEK BENGIL – The Original Crispy Duck Since 1990. The exact place where you can experience peaceful atmosphere, along with serene ambiance streaming down through the soul to recover yourself from the busy life."
        ),
        Restaurant(
            name: "BOOST JUICE BAR",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/04/BOOST-JUICE-BAR-1.jpg",
            description: "After almost a decade of climbing the corporate ladder, Nick & Soraya decided to leave that world behind, and in 2009 they opened their very first Boost store at the KL Twin Towers Suria KLCC, Malaysia."
        ),
        Restaurant(
            name: "Brewerkz",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BREWERKZ.jpg",
            description: "Brewerkz Jakarta is a restaurant, bar and microbrewery franchise brought from Singapore. Open since 1997, the concept specializes in classic American styled food and award winning handcrafted beers."
        ),
        Restaurant(
            name: "Burgreens",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BURGREENS.jpg",
            description: "Burgreens is the leading plant-based food chain in Indonesia specializing in delicious Asian & Western cuisines. We make all our food from scratch to ensure that all your meals are free from MSG & chemical flavor enhancers."
        ),
        Restaurant(
            name: "Chakra Hall",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/CHAKRA.jpg",
            description: "Nama Chakra diambil dari definisi Chakra sendiri adalah pusat energi yang selalu berputar dan bergerak aktif, dengan harapan Chakra menjadi tempat yang membawa energi positif."
        ),
        Restaurant(
            name: "CHATERAISE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/CHATERAISE.jpg",
            description: "December 1954, the first Chateraise was opened in the foothills of Mt. Fuji. Today, the brand has expanded to over 470 shops across Japan and 24 shops around the world."
        ),
        Restaurant(
            name: "Chatime",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/CHATIME.jpg",
            description: "Chatime merupakan penyedia menuman brewed tea asal Taiwan yang menghadirkan lebih dari 50 varian rasa. Di Indonesia, Chatime merupakan salah satu bisnis unit di bawah payung Kawan Lama Group."
        ),
        Restaurant(
            name: "CHONG QING HOT POT",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/CHONG-QING-HOT-POT.jpg",
            description: "Welcome to Chong Qing's newest home at The Breeze BSD City, where the aroma of bubbling broths and warm smiles greet you at every turn."
        ),
        Restaurant(
            name: "Colico",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/COLICO-1.jpg",
            description: "Welcome to the tropical world of COLICO, here at COLICO we only serves refreshing juice made from 100% REAL fruits harvested mainly from numerous tropical islands of Indonesia."
        ),
        Restaurant(
            name: "CROCO",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/02/CROCO.jpg",
            description: "CROCO carries the 'Bakery Cafe' concept, serving freshly baked croissants, viennoiseries and pastries daily, paired with a variety of coffee and tea drinks."
        ),
        Restaurant(
            name: "Cut & Grill",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/CUTT-GRILL.jpg",
            description: "If you are looking for the best steakhouse with a delightful grilling experience, come to Cutt & Grill! We use quality ingredients to serve delicious food."
        ),
        Restaurant(
            name: "D'COST",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2022/03/DCOST-1.jpg",
            description: "D'COST Seafood pertama didirikan tanggal 9 September 2006. Saat itu D'COST Seafood melihat sebuah peluang untuk mendirikan jaringan restoran yang menyajikan hidangan laut."
        ),
        Restaurant(
            name: "DORE by LeTAO",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/DORE.jpg",
            description: "DORÉ by LeTAO excels in crafting quality cakes and desserts with an aim to accompany you along a gratifying journey of taste."
        ),
        Restaurant(
            name: "Dum Dum Thai Tea",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/DUM-DUM.jpg",
            description: "Menikmati rasa otentik Thai Tea kini dapat langsung dengan mudah didapatkan di berbagai tempat di Indonesia."
        ),
        Restaurant(
            name: "Fire Prawn",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/10/FIRE-PRAWN.jpg",
            description: "Manjakan diri dalam petualangan kuliner yang tiada duanya di Fire Prawn, pintu gerbang Anda menuju dunia masakan Cina yang semarak."
        ),
        Restaurant(
            name: "Fore Coffee",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/FORE-1.jpg",
            description: "Coffee"
        ),
        Restaurant(
            name: "FRUITY JUICE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/FRUITY.jpg",
            description: "Fruity Indonesia adalah salah satu pionir dalam bisnis retail jus di kota Bandung yang dimulai pada tahun 1999."
        ),
        Restaurant(
            name: "GALLURA",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/GALLURA.jpg",
            description: "Located at The Breeze BSD, offering an authentic taste of Italy in a cozy and inviting atmosphere."
        ),
        Restaurant(
            name: "GINDACO",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2022/01/GINDACO.jpg",
            description: "Ever wonder how does authentic takoyaki tastes? It's time to try Gindaco! Gindaco serves premium takoyaki balls filled with high-quality, imported fresh cut octopus."
        ),
        Restaurant(
            name: "Gion",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/GION-2.jpg",
            description: "GION The Sushi Bar adalah restaurant Jepang yang memiliki interior unik dengan makanan yang bermacam-macam varian, diantaranya yaitu Sushi, Sashimi, Donburi, Ramen, Udon."
        ),
        Restaurant(
            name: "Gubug Makan Mang Engking",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/GBG-MANG-ENGKING-2.jpg",
            description: "Citarasa Nusantara Gubug Makan Mang Engking, The Breeze BSD City specializes in authentic Sundanese cuisine set upon a natural environment with traditional huts."
        ),
        Restaurant(
            name: "Hachi Grill",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2022/01/HACHI-GRILL-1.jpg",
            description: "Hachi Grill The Breeze is the ultimate place to delight the quality of meat and fresh hydroponic vegetables at the best price."
        ),
        Restaurant(
            name: "Han Guksu",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/08/HANGUKSU-01-01.jpg",
            description: "Han Guksu is taken from the word 'Hanguk' and 'Guksu', which means 'Korean Noodle Dishes'."
        ),
        Restaurant(
            name: "Honu",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/HONU-1.jpg",
            description: "Honu's menu is a modern take on the classic Hawaiian dish and traditional Japanese tea to create an accessible and wholesome dining ritual."
        ),
        Restaurant(
            name: "Ikkudo Ichi",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/IKKUDO-ICHI-1.jpg",
            description: "Ikkudo Ichi serves Authentic Japanese ramen which has been adapted to Indonesian tastes since 2012."
        ),
        Restaurant(
            name: "J.CO Donut & Coffee",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/JCO-1.jpg",
            description: "JCO's first store was opened in May 2006 in Indonesia as a result of many years of research & development and true labor of love over our products."
        ),
        Restaurant(
            name: "Jalarasa",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/JALARASA.jpg",
            description: "Serving Indonesian cuisine with various flavors from the sea that use high quality and fresh ingredients that make your palate dancing."
        ),
        Restaurant(
            name: "Jittlada",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/JITTLADA.jpg",
            description: "Sawadika and welcome to Jittlada Thai Cuisine. Our design appeals to family dining with Royal touch."
        ),
        Restaurant(
            name: "Katsukita",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/KATSUKITA-1.jpg",
            description: "Serves a Japanese dish in the form of sliced chicken meat wrapped in breadcrumb which is called Chicken Katsu as the main menu with a variety of flavors."
        ),
        Restaurant(
            name: "KITCHENETTE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/KITCHENETTE.jpg",
            description: "The cozy and inviting eatery where you can enjoy the comfort of home-style cooking in a casual and relaxed atmosphere."
        ),
        Restaurant(
            name: "Kumulo",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/KUMULO-1.jpg",
            description: "Kumulo Creative Compound is an outdoor creative compound of 25 curated micro-shops of artisans and creatives who uphold the spirit of collaboration."
        ),
        Restaurant(
            name: "LEKO",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/LEKO-2.jpg",
            description: "Lekko spesialis Iga Sapi Penyet. Pioneer Iga Penyet pertama di Indonesia."
        ),
        Restaurant(
            name: "MARUGAME UDON",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/04/MARUGAME-UDON.jpg",
            description: "Marugame Udon is the best Udon & Tempura from Japan. All recipes used are original recipes from Marugame Japan."
        ),
        Restaurant(
            name: "Montato",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/MONTATO.jpg",
            description: "Specialises in crunchy and tasty japanese monstrous potato fries. Freshly fried when you order."
        ),
        Restaurant(
            name: "NOB Bakery",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/NOB-1.jpg",
            description: "NOB menyediakan berbagai aneka pastry seperti Croissant, Canele, Cruffin, Mini Cakes, Soft Cookies, dan Cookies in a Jar."
        ),
        Restaurant(
            name: "Old Town Coffee",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/OLD-TOWN-1.jpg",
            description: "Old Town in Ipoh, Malaysia, is where the very first traditional white coffee was created. With its long-lasting aroma and authentic taste."
        ),
        Restaurant(
            name: "PAUL LE CAFE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2022/06/PAUL-LE-CAFE.jpg",
            description: "It proposes a new kind of coffee (from 100% Arabica only) and the food offered is also slightly different."
        ),
        Restaurant(
            name: "REJUVE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2022/11/REJUVE-1.jpg",
            description: "Everyday, Every Lifestyle, and Everyone"
        ),
        Restaurant(
            name: "SAIGON DELIGHT",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/10/SAIGON-DELIGHT-01.jpg",
            description: "Saigon Delight at The Breeze BSD is giving a holiday in Vietnam vibe. The spacious atmosphere, tropical fresh décor, and authentic Vietnamese menu are perfect for dining."
        ),
        Restaurant(
            name: "SAKE BIRU",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/02/SAKE-BIRU.jpg",
            description: "The traditional and modern izakaya interior, serving not only yakitori but other Japanese dishes as well."
        ),
        Restaurant(
            name: "Salad Stop",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2025/01/SALAD-STOP-01.jpg",
            description: "SaladStop! is a leader in providing fresh, healthy salads, wraps, super protein bowls, and activated smoothies."
        ),
        Restaurant(
            name: "Sate Senayan",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/SATE-SENAYAN-2.jpg",
            description: ""
        ),
        Restaurant(
            name: "Shihlin",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/SHIHLIN-1.jpg",
            description: "Thousands of Taiwanese crowd the local night markets in search of their favourite and delicious snacks, and Taipei's Shihlin Night Market is the most famous."
        ),
        Restaurant(
            name: "SINAMON",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/02/SINAMON.jpg",
            description: "We do our best to serve them straight out of the oven, just like your grandma used to make 'em!"
        ),
        Restaurant(
            name: "SOUR SALLY",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/SOUR-SALLY-1.jpg",
            description: "Sour Sally Non-Fat Frozen Yogurt or simply known as 'Fro-yo' was the first of its kind in Indonesia back in 2008."
        ),
        Restaurant(
            name: "Starbucks",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/STARBUCKS.jpg",
            description: "Our story began in 1971. Back then we were a roaster and retailer of whole bean and ground coffee, tea and spices with a single store in Seattle's Pike Place Market."
        ),
        Restaurant(
            name: "Subway",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/SUBWAY.jpg",
            description: "Subway adalah restoran berantai dan waralaba makanan internasional asal Amerika Serikat yang menghidangkan roti lapis kapal selam."
        ),
        Restaurant(
            name: "Sushi Tei",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/SUSHI-TEI.jpg",
            description: "Sushi Tei - where expert culinary skills and an innate appreciation of nature come together to inspire and enhance the Japanese dining experience."
        ),
        Restaurant(
            name: "TAMPER COFFEE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/TAMPER.jpg",
            description: "The primary goal with tamping coffee is to compact the bed of coffee and create a flat and even surface, for the pressurised water to flow through."
        ),
        Restaurant(
            name: "THE PANCAKE CO.",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/THE-PANCAKE-CO..jpg",
            description: "Starting from our fluffiest soufflé pancakes in town that could take you to Cloud 9, delectable Yōshoku cuisine, to fun and refreshing drinks."
        ),
        Restaurant(
            name: "THE PEOPLE'S CAFE",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2024/04/THE-PEOPLES-CAFE.jpg",
            description: "An accessible wide selection of your favorite local street food. Convenient spot for informal meetings, hangouts, or casual family time."
        ),
        Restaurant(
            name: "VILLA CAPRI",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/04/VILLA-CAPRI.jpg",
            description: "Villa Capri at The Breeze, Tangerang, where Italian cuisine takes center stage. With the motto 'Buon cibo, buon vino, buoni amici' (Good food, good wine, good friends)."
        ),
        Restaurant(
            name: "VIVOLI GELATO",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/02/VIVOLI.jpg",
            description: "Handcrafted Artisan Gelato is our philosophy to create a fresh produced, enjoyable & safe to consume dessert for anyone who is a lactose intolerant, a vegan or allergic to nuts."
        ),
        Restaurant(
            name: "Wee Nam Kee",
            thumbnail: "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/WEE-NAM-KEE-1.jpg",
            description: "Wee Nam Kee adalah Asian restaurant berasal dari Singapore yang memiliki menu andalan yaitu Hainan Chicken Rice."
        )
    ]
}
