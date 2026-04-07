# Load Libraries 
library(tidyverse)
library(ggplot2)

# Create a dataset called: customer_orders.
customer_orders <- tibble(
  customer_id = c("C101", "C102", "C103", "C104", "C105", "C106", "C107", "C108", "C109", "C110"),
  product_category = c("Electronics", "Clothing", "Groceries", "Electronics", "Clothing", "Groceries", "Electronics", "Clothing", "Groceries", "Electronics"),
  payment_method = c("Card", "Cash", "Card", "Transfer", "Card", "Cash", "Card", "Transfer", "Card", "Cash"),
  city = c("Lagos", "Abuja", "Lagos", "Port Harcourt", "Abuja", "Lagos", "Kano", "Port Harcourt", "Kano", "Abuja"),
  quantity = c(1, 3, 5, 2, 4, 8, 1, 2, 6, 1),
  unit_price = c(800, 40, 10, 600, 35, 8, 900, 50, 12, 750)
)
customer_orders

# Create a new column: total_revenue = quantity × unit_price
customer_orders <- customer_orders %>%
  mutate(
    total_revenue = quantity * unit_price
  )
customer_orders

# Convert these columns into factors: product_category, payment_method and city
customer_orders <- customer_orders %>%
  mutate(
    product_category = factor(product_category),
    payment_method = factor(payment_method),
    city = factor(city)
  )
customer_orders

# Create a dataset called: category_revenue. Show: product_category and total revenue
category_revenue <- customer_orders %>%
  group_by(product_category) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(desc(total_revenue))
category_revenue

# Create: city_revenue. Show which city generates the most revenue.
city_revenue <- customer_orders %>%
  group_by(city) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(desc(total_revenue))
city_revenue

# Create a dataset showing: payment_method vs total revenue. This tells companies how customers prefer paying.
payment_method_choice <- customer_orders %>%
  group_by(payment_method) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(desc(total_revenue))
payment_method_choice

# Find orders where: total_revenue > 500
higher_orders <- customer_orders %>%
  filter(total_revenue > 500)
higher_orders

# Create three charts using ggplot2. Chart 1: Product Category vs Total Revenue. 
customer_orders %>%
  group_by(product_category) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(product_category) %>%
  ggplot(aes(x = product_category, y = total_revenue, fill = product_category)) +
  geom_col() +
  labs(
    title = "Product Category vs Total Revenue",
    x = "Product Category",
    y = "Total Revenue"
  )

# Chart 2: City vs Total Revenue
customer_orders %>%
  group_by(city) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(city) %>%
  ggplot(aes(x = city, y = total_revenue, fill = city)) +
  geom_col() +
  labs(
    title = "City vs Total Revenue",
    x = "City",
    y = "Total Revenue"
  )

# Chart 3: payment Method vs Total Revenue
customer_orders %>%
  group_by(payment_method) %>%
  summarise(total_revenue = sum(total_revenue)) %>%
  arrange(payment_method) %>%
  ggplot(aes(x = payment_method, y = total_revenue, fill = payment_method)) +
  geom_col() +
  labs(
    title = "Payment Method vs Total Revenue",
    x = "Payment Method",
    y = "Total Revenue"
  )

