// FashionStore Curated Product & Category Database for Vercel Showcase
const CATEGORIES = [
  { id: 1, name: "Men" },
  { id: 2, name: "Women" },
  { id: 3, name: "Kids" },
  { id: 4, name: "Shoes" },
  { id: 5, name: "Watches" },
  { id: 6, name: "Bags" },
  { id: 7, name: "Accessories" },
  { id: 8, name: "Sportswear" },
];

const PRODUCTS = [
  {
    id: 1,
    categoryId: 1,
    name: "Black Casual Shirt",
    brand: "Roadster",
    description: "Men black casual cotton shirt",
    price: 1299.0,
    imageUrl: "assets/images/products/black-casual-shirt.jpg",
    variants: [{ id: 1, size: "S", stock: 3 }, { id: 2, size: "M", stock: 25 }, { id: 3, size: "L", stock: 18 }, ]
  },
  {
    id: 2,
    categoryId: 1,
    name: "Blue Slim Fit Jeans",
    brand: "Levis",
    description: "Men blue slim fit stretch jeans",
    price: 1999.0,
    imageUrl: "assets/images/products/blue-slim-fit-jeans.jpg",
    variants: [{ id: 4, size: "30", stock: 12 }, { id: 5, size: "32", stock: 20 }, { id: 6, size: "34", stock: 12 }, ]
  },
  {
    id: 3,
    categoryId: 1,
    name: "White Polo T-Shirt",
    brand: "US Polo",
    description: "Premium white polo t-shirt",
    price: 999.0,
    imageUrl: "assets/images/products/white-polo-tshirt.jpg",
    variants: [{ id: 7, size: "S", stock: 24 }, { id: 8, size: "M", stock: 30 }, { id: 9, size: "L", stock: 20 }, ]
  },
  {
    id: 4,
    categoryId: 1,
    name: "Green Hoodie",
    brand: "H&M",
    description: "Cotton winter hoodie",
    price: 1899.0,
    imageUrl: "assets/images/products/green-hoodie.jpg",
    variants: [{ id: 10, size: "M", stock: 14 }, { id: 11, size: "L", stock: 20 }, { id: 12, size: "XL", stock: 1 }, ]
  },
  {
    id: 5,
    categoryId: 1,
    name: "Denim Jacket",
    brand: "Wrangler",
    description: "Classic blue denim jacket",
    price: 2499.0,
    imageUrl: "assets/images/products/men/denim-jacket.jpg",
    variants: [{ id: 13, size: "M", stock: 18 }, { id: 14, size: "L", stock: 22 }, { id: 15, size: "XL", stock: 15 }, ]
  },
  {
    id: 6,
    categoryId: 2,
    name: "Floral Summer Dress",
    brand: "Zara",
    description: "Printed floral summer dress",
    price: 2499.0,
    imageUrl: "assets/images/products/women/floral-dress.jpg",
    variants: [{ id: 16, size: "S", stock: 20 }, { id: 17, size: "M", stock: 25 }, { id: 18, size: "L", stock: 18 }, ]
  },
  {
    id: 7,
    categoryId: 2,
    name: "Pink Kurti",
    brand: "Biba",
    description: "Women straight pink kurti",
    price: 1499.0,
    imageUrl: "assets/images/products/women/pink-kurti.jpg",
    variants: [{ id: 19, size: "S", stock: 15 }, { id: 20, size: "M", stock: 22 }, { id: 21, size: "L", stock: 14 }, ]
  },
  {
    id: 8,
    categoryId: 2,
    name: "Black High Waist Jeans",
    brand: "Only",
    description: "Stretch high waist jeans",
    price: 2199.0,
    imageUrl: "assets/images/products/women/black-jeans.jpg",
    variants: [{ id: 22, size: "28", stock: 12 }, { id: 23, size: "30", stock: 18 }, { id: 24, size: "32", stock: 15 }, ]
  },
  {
    id: 9,
    categoryId: 2,
    name: "White Crop Top",
    brand: "H&M",
    description: "Casual white crop top",
    price: 899.0,
    imageUrl: "assets/images/products/women/crop-top.jpg",
    variants: [{ id: 25, size: "S", stock: 20 }, { id: 26, size: "M", stock: 24 }, { id: 27, size: "L", stock: 16 }, ]
  },
  {
    id: 10,
    categoryId: 2,
    name: "Blue Denim Skirt",
    brand: "Levis",
    description: "Stylish blue denim skirt",
    price: 1699.0,
    imageUrl: "assets/images/products/women/denim-skirt.jpg",
    variants: [{ id: 28, size: "S", stock: 14 }, { id: 29, size: "M", stock: 20 }, { id: 30, size: "L", stock: 12 }, ]
  },
  {
    id: 11,
    categoryId: 3,
    name: "Kids Checked Shirt",
    brand: "Max",
    description: "Checked cotton shirt for boys",
    price: 999.0,
    imageUrl: "assets/images/products/kids/checked-shirt.jpg",
    variants: [{ id: 31, size: "24", stock: 15 }, { id: 32, size: "26", stock: 20 }, { id: 33, size: "28", stock: 18 }, ]
  },
  {
    id: 12,
    categoryId: 3,
    name: "Kids Party Dress",
    brand: "Hopscotch",
    description: "Girls party wear dress",
    price: 1799.0,
    imageUrl: "assets/images/products/kids/party-dress.jpg",
    variants: [{ id: 34, size: "24", stock: 12 }, { id: 35, size: "26", stock: 18 }, { id: 36, size: "28", stock: 15 }, ]
  },
  {
    id: 13,
    categoryId: 3,
    name: "Kids Hoodie",
    brand: "Puma",
    description: "Warm hoodie for kids",
    price: 1299.0,
    imageUrl: "assets/images/products/kids/hoodie.jpg",
    variants: [{ id: 37, size: "S", stock: 18 }, { id: 38, size: "M", stock: 24 }, { id: 39, size: "L", stock: 20 }, ]
  },
  {
    id: 14,
    categoryId: 3,
    name: "Kids Shorts",
    brand: "Max",
    description: "Comfortable cotton shorts",
    price: 699.0,
    imageUrl: "assets/images/products/kids/shorts.jpg",
    variants: [{ id: 40, size: "24", stock: 16 }, { id: 41, size: "26", stock: 22 }, { id: 42, size: "28", stock: 18 }, ]
  },
  {
    id: 15,
    categoryId: 3,
    name: "Kids T-Shirt",
    brand: "Nike",
    description: "Sports t-shirt for kids",
    price: 799.0,
    imageUrl: "assets/images/products/kids/tshirt.jpg",
    variants: [{ id: 43, size: "S", stock: 20 }, { id: 44, size: "M", stock: 25 }, { id: 45, size: "L", stock: 22 }, ]
  },
  {
    id: 16,
    categoryId: 4,
    name: "Running Shoes",
    brand: "Nike",
    description: "Lightweight running shoes",
    price: 3999.0,
    imageUrl: "assets/images/products/shoes/running-shoes.jpg",
    variants: [{ id: 46, size: "7", stock: 18 }, { id: 47, size: "8", stock: 25 }, { id: 48, size: "9", stock: 20 }, ]
  },
  {
    id: 17,
    categoryId: 4,
    name: "Sneakers",
    brand: "Adidas",
    description: "White casual sneakers",
    price: 3499.0,
    imageUrl: "assets/images/products/shoes/sneakers.jpg",
    variants: [{ id: 49, size: "7", stock: 15 }, { id: 50, size: "8", stock: 22 }, { id: 51, size: "9", stock: 18 }, ]
  },
  {
    id: 18,
    categoryId: 4,
    name: "Formal Shoes",
    brand: "Bata",
    description: "Leather formal shoes",
    price: 2999.0,
    imageUrl: "assets/images/products/shoes/formal-shoes.jpg",
    variants: [{ id: 52, size: "7", stock: 12 }, { id: 53, size: "8", stock: 18 }, { id: 54, size: "9", stock: 15 }, ]
  },
  {
    id: 19,
    categoryId: 4,
    name: "Sports Shoes",
    brand: "Puma",
    description: "Comfortable sports shoes",
    price: 3799.0,
    imageUrl: "assets/images/products/shoes/sports-shoes.jpg",
    variants: [{ id: 55, size: "7", stock: 20 }, { id: 56, size: "8", stock: 24 }, { id: 57, size: "9", stock: 22 }, ]
  },
  {
    id: 20,
    categoryId: 4,
    name: "Sandals",
    brand: "Woodland",
    description: "Outdoor sandals",
    price: 2299.0,
    imageUrl: "assets/images/products/shoes/sandals.jpg",
    variants: [{ id: 58, size: "7", stock: 18 }, { id: 59, size: "8", stock: 20 }, { id: 60, size: "9", stock: 16 }, ]
  },
  {
    id: 21,
    categoryId: 5,
    name: "Titan Analog Watch",
    brand: "Titan",
    description: "Premium analog watch with leather strap",
    price: 4599.0,
    imageUrl: "assets/images/products/watches/titan-analog.jpg",
    variants: [{ id: 61, size: "Free", stock: 25 }, { id: 62, size: "Premium", stock: 15 }, { id: 63, size: "Limited", stock: 10 }, ]
  },
  {
    id: 22,
    categoryId: 5,
    name: "Fastrack Digital Watch",
    brand: "Fastrack",
    description: "Digital sports watch",
    price: 2499.0,
    imageUrl: "assets/images/products/watches/fastrack-digital.jpg",
    variants: [{ id: 64, size: "Free", stock: 30 }, { id: 65, size: "Premium", stock: 20 }, { id: 66, size: "Limited", stock: 12 }, ]
  },
  {
    id: 23,
    categoryId: 5,
    name: "Noise Smart Watch",
    brand: "Noise",
    description: "Bluetooth smart watch with heart rate monitoring",
    price: 3999.0,
    imageUrl: "assets/images/products/watches/noise-smart.jpg",
    variants: [{ id: 67, size: "Free", stock: 28 }, { id: 68, size: "Premium", stock: 18 }, { id: 69, size: "Limited", stock: 10 }, ]
  },
  {
    id: 24,
    categoryId: 5,
    name: "Casio Vintage Watch",
    brand: "Casio",
    description: "Classic vintage digital watch",
    price: 3299.0,
    imageUrl: "assets/images/products/watches/casio-vintage.jpg",
    variants: [{ id: 70, size: "Free", stock: 22 }, { id: 71, size: "Premium", stock: 16 }, { id: 72, size: "Limited", stock: 8 }, ]
  },
  {
    id: 25,
    categoryId: 5,
    name: "Sonata Casual Watch",
    brand: "Sonata",
    description: "Affordable casual wrist watch",
    price: 1899.0,
    imageUrl: "assets/images/products/watches/sonata-casual.jpg",
    variants: [{ id: 73, size: "Free", stock: 34 }, { id: 74, size: "Premium", stock: 22 }, { id: 75, size: "Limited", stock: 15 }, ]
  },
  {
    id: 26,
    categoryId: 6,
    name: "Laptop Backpack",
    brand: "Skybags",
    description: "Water resistant laptop backpack",
    price: 1899.0,
    imageUrl: "assets/images/products/bags/laptop-backpack.jpg",
    variants: [{ id: 76, size: "Free", stock: 30 }, { id: 77, size: "Large", stock: 20 }, { id: 78, size: "XL", stock: 10 }, ]
  },
  {
    id: 27,
    categoryId: 6,
    name: "Travel Backpack",
    brand: "Wildcraft",
    description: "Large capacity travel backpack",
    price: 2499.0,
    imageUrl: "assets/images/products/bags/travel-backpack.jpg",
    variants: [{ id: 79, size: "Free", stock: 25 }, { id: 80, size: "Large", stock: 18 }, { id: 81, size: "XL", stock: 12 }, ]
  },
  {
    id: 28,
    categoryId: 6,
    name: "Women Handbag",
    brand: "Caprese",
    description: "Stylish women handbag",
    price: 2299.0,
    imageUrl: "assets/images/products/bags/women-handbag.jpg",
    variants: [{ id: 82, size: "Free", stock: 20 }, { id: 83, size: "Large", stock: 15 }, { id: 84, size: "XL", stock: 10 }, ]
  },
  {
    id: 29,
    categoryId: 6,
    name: "Office Bag",
    brand: "American Tourister",
    description: "Professional office bag",
    price: 2799.0,
    imageUrl: "assets/images/products/bags/office-bag.jpg",
    variants: [{ id: 85, size: "Free", stock: 22 }, { id: 86, size: "Large", stock: 16 }, { id: 87, size: "XL", stock: 8 }, ]
  },
  {
    id: 30,
    categoryId: 6,
    name: "Gym Bag",
    brand: "Nike",
    description: "Spacious gym duffle bag",
    price: 1699.0,
    imageUrl: "assets/images/products/bags/gym-bag.jpg",
    variants: [{ id: 88, size: "Free", stock: 28 }, { id: 89, size: "Large", stock: 20 }, { id: 90, size: "XL", stock: 12 }, ]
  },
  {
    id: 31,
    categoryId: 7,
    name: "Leather Belt",
    brand: "Allen Solly",
    description: "Premium genuine leather belt",
    price: 799.0,
    imageUrl: "assets/images/products/accessories/leather-belt.jpg",
    variants: [{ id: 91, size: "Free", stock: 30 }, { id: 92, size: "Premium", stock: 20 }, { id: 93, size: "Limited", stock: 10 }, ]
  },
  {
    id: 32,
    categoryId: 7,
    name: "Leather Wallet",
    brand: "Woodland",
    description: "Brown genuine leather wallet",
    price: 999.0,
    imageUrl: "assets/images/products/accessories/wallet.jpg",
    variants: [{ id: 94, size: "Free", stock: 25 }, { id: 95, size: "Premium", stock: 18 }, { id: 96, size: "Limited", stock: 12 }, ]
  },
  {
    id: 33,
    categoryId: 7,
    name: "Sunglasses",
    brand: "Ray-Ban",
    description: "UV protected stylish sunglasses",
    price: 3499.0,
    imageUrl: "assets/images/products/accessories/sunglasses.jpg",
    variants: [{ id: 97, size: "Free", stock: 20 }, { id: 98, size: "Premium", stock: 15 }, { id: 99, size: "Limited", stock: 8 }, ]
  },
  {
    id: 34,
    categoryId: 7,
    name: "Sports Cap",
    brand: "Nike",
    description: "Adjustable cotton sports cap",
    price: 599.0,
    imageUrl: "assets/images/products/accessories/cap.jpg",
    variants: [{ id: 100, size: "Free", stock: 28 }, { id: 101, size: "Premium", stock: 20 }, { id: 102, size: "Limited", stock: 12 }, ]
  },
  {
    id: 35,
    categoryId: 7,
    name: "Cotton Socks",
    brand: "Puma",
    description: "Pack of 3 premium cotton socks",
    price: 399.0,
    imageUrl: "assets/images/products/accessories/socks.jpg",
    variants: [{ id: 103, size: "Free", stock: 35 }, { id: 104, size: "Premium", stock: 25 }, { id: 105, size: "Limited", stock: 15 }, ]
  },
  {
    id: 36,
    categoryId: 8,
    name: "Gym T-Shirt",
    brand: "Adidas",
    description: "Dry-fit gym t-shirt for workouts",
    price: 1199.0,
    imageUrl: "assets/images/products/sportswear/gym-tshirt.jpg",
    variants: [{ id: 106, size: "S", stock: 20 }, { id: 107, size: "M", stock: 25 }, { id: 108, size: "L", stock: 18 }, ]
  },
  {
    id: 37,
    categoryId: 8,
    name: "Track Pants",
    brand: "Puma",
    description: "Comfortable sports track pants",
    price: 1699.0,
    imageUrl: "assets/images/products/track-pants.jpg",
    variants: [{ id: 109, size: "M", stock: 22 }, { id: 110, size: "L", stock: 20 }, { id: 111, size: "XL", stock: 15 }, ]
  },
  {
    id: 38,
    categoryId: 8,
    name: "Sports Shorts",
    brand: "Nike",
    description: "Lightweight running shorts",
    price: 999.0,
    imageUrl: "assets/images/products/sports-shorts.jpg",
    variants: [{ id: 112, size: "S", stock: 18 }, { id: 113, size: "M", stock: 22 }, { id: 114, size: "L", stock: 16 }, ]
  },
  {
    id: 39,
    categoryId: 8,
    name: "Training Jacket",
    brand: "Reebok",
    description: "Full sleeve training jacket",
    price: 2499.0,
    imageUrl: "assets/images/products/training-jacket.jpg",
    variants: [{ id: 115, size: "M", stock: 20 }, { id: 116, size: "L", stock: 18 }, { id: 117, size: "XL", stock: 12 }, ]
  },
  {
    id: 40,
    categoryId: 8,
    name: "Compression Tights",
    brand: "Under Armour",
    description: "Performance compression tights",
    price: 2199.0,
    imageUrl: "assets/images/products/compression-tights.jpg",
    variants: [{ id: 118, size: "S", stock: 15 }, { id: 119, size: "M", stock: 20 }, { id: 120, size: "L", stock: 15 }, ]
  },
];

