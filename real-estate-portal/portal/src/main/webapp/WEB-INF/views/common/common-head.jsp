<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Marcellus&family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --gold: #c5a059;
        --dark-navy: #0a1128;
        --emerald: #00b98e;
        --orange: #ff5a3c;
        --white: #ffffff;
        --bg-light: #f8f9fa;
        --border-color: rgba(0,0,0,0.05);
    }

    body { 
        font-family: 'Plus Jakarta Sans', sans-serif; 
        background: #fff; 
        color: var(--dark-navy); 
        overflow-x: hidden; 
    }

    .brand { font-family: 'Marcellus', serif; text-decoration: none; }
    .brand span { color: var(--emerald); }

    /* Utility classes for the theme */
    .text-gold { color: var(--gold); }
    .text-emerald { color: var(--emerald); }
    .bg-navy { background-color: var(--dark-navy); }
    
    .btn-premium {
        background: var(--orange);
        color: white;
        border-radius: 12px;
        padding: 12px 24px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: none;
    }
    .btn-premium:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(255, 90, 60, 0.2);
        color: white;
    }
</style>
