# E-commerce Conversion Funnel Analysis

Where do shoppers drop off between viewing a product, adding it to the cart and buying it, and which categories and brands convert best?

## Business questions
- What share of viewers add to cart, and what share of those buy?
- Which categories and brands convert best and worst?
- How does price affect conversion?
- How many carts are abandoned?

## Data
E-commerce Events History in Electronics Store (Kaggle, REES46): https://www.kaggle.com/datasets/mkechinov/ecommerce-events-history-in-electronics-store, downloaded (24th October 2026), 885,129 rows (884,312 after cleaning), 24 Sep 2020 to 28 Feb 2021.

## Approach
Tools: Python (pandas), SQL (DuckDB) in Google Colab.

Cleaning steps: Read user_id as text to avoid rounding; converted event_time to datetime; removed exact duplicate rows and rows with no session ID (885,129 to 884,312 rows); labelled missing brand (24.0%) and category (26.7%) as "unknown" instead of deleting them.

## Key findings
- Only 8.4% of sessions that view a product go on to add one to the cart (41,250 of 488,360). This is the biggest drop in the funnel.
- Half (49.7%) of cart sessions end in a purchase (20,518 of 41,250), so about half of carts are abandoned.
- Overall, 4.2% of sessions that view a product end in a purchase.
- Limitation: 3,582 purchase sessions have no cart event, so the true cart-to-purchase rate lies between 49.7% (strict) and 59.0% (any session with both events).
- Limitation: about a quarter of products have no brand or category, so category and brand comparisons are partial.
- Computers convert best among large categories: 13.2% of sessions that view a computer product add one to the cart, and 6.2% end in a purchase, roughly double electronics (3.8%).
- Appliances have high traffic (25,303 viewed sessions) but low conversion: 4.0% add to cart and 2.1% buy.
- Cart-to-purchase stays between about 45% and 59% across categories, so the differences come mostly from the view-to-cart step.
- Only categories with at least 100 carted sessions are compared; smaller ones are too noisy to rank. About a quarter of products have no category.
  
## Dashboard
(screenshots go here)

## What I would do next
(fill in at the end)
