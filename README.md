
# **Shrimp & Crab Job Script for FiveM (ESX / Ox Inventory)**

## **Overview**

The **Shrimp & Crab Job Script** is a custom resource for FiveM servers running on the **ESX framework**, designed to allow players to collect, process, and sell shrimp and crab. Using **ox\_inventory**, players can gather seafood, process it into packed seafood, and then sell it for in-game currency.

This script adds an interactive roleplay job for your server, enhancing the immersion and economic opportunities for your players.

## **Features**

* **Collect Seafood:**
  Players can collect shrimp or crab by interacting with the environment. The collection process has a random chance of varying amounts.

* **Processing:**
  Players can process their collected shrimp and crab into "Packed Shrimp" and "Packed Crab." The processing happens in batches of 5. A minimum of 5 items is required to process the batch.

* **Selling:**
  Players can sell their processed packed seafood at a designated selling point. The value of the sale is based on the quantity of packed seafood, and the earnings are added to the player's money.

* **Discord Logging:**
  Every time a player sells packed shrimp or crab, a log is sent to a Discord webhook with details including the player's name, license, and the items they sold, along with the total money earned.

## **How It Works**

### 1. **Collecting Seafood:**

* Players can collect either **Crab** or **Shrimp** from specific locations in the world.
* The collection rate varies, and players receive 1, 5, or 10 items based on a random chance.

### 2. **Processing:**

* Players must have at least **5 crab** or **5 shrimp** to process them into "Packed Crab" or "Packed Shrimp."
* If a player has sufficient items, the script processes them in batches of 5.
* The player receives 1 "Packed" item per batch processed.

### 3. **Selling:**

* Players can sell their **Packed Shrimp** and **Packed Crab** at a selling location.
* The sale value is calculated based on the quantity of packed seafood, and the total money earned is added to their account.

### 4. **Logging:**

* When a player sells seafood, the script sends a detailed log to a Discord channel, including:

  * Player’s in-game name
  * Player's license ID
  * Number of Packed Shrimp and Packed Crab sold
  * Total money earned

## **Requirements**

* **ESX Framework** (for server-side player management)
* **Ox Inventory** (for inventory management)
* **Discord Webhook URL** (for logging sales to Discord)

## **Configuration**

* You can configure the following in the **`Config.lua`** file:

  * **Items:** The item names for **Crab**, **Shrimp**, **Packed Crab**, and **Packed Shrimp**.
  * **Prices:** Set the sale prices for **Packed Crab** and **Packed Shrimp**.
  * **Processing Time:** Duration of time for processing seafood into packed items.
  * **Webhook URL:** Set the Discord webhook URL for logging seafood sales.

## **Installation**

1. Download the script and place it in your `resources` folder.
2. Add `start shrimp_crab_job` in your server's `server.cfg`.
3. Customize the `Config.lua` to set up the items, prices, and Discord webhook.
4. Ensure you have **ESX** and **ox\_inventory** properly set up on your server.

## **Commands & Keybinds**

* **Collect Seafood**: Interact with the collection point to gather Crab or Shrimp.
* **Process Seafood**: Stand near the processing point and press the "E" key to start processing.
* **Sell Seafood**: Stand near the selling point and press the "E" key to sell the packed seafood.

## **Changelog**

* **Version 1.0**: Initial release with collection, processing, selling, and Discord logging features.

## **License**

This project is licensed under the MIT License.
