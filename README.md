CurrencyTracker
===============

CurrencyTracker allows multiple users to track their personal collections of world currencies, by tagging the countries that they've visited along your travels.

Features
--------

* Users
* Track Visited Countries
* Track Collected Currencies
* Charts show you how far along you are!

Installation
------------

The version of Ruby Enterprise Edition listed in the .rvmrc is no longer available for download, so press cancel if prompted to trust the file. This application works with regular Ruby 1.8.7.

Now run 'bundle install' and 'rake db:migrate' to load the gems and create the database. To preload some countries and currencies into the database, run 'rake db:fixtures:load'.

This will load 16 preset currencies, countries from North America, Europe, and Australia. Included are several Euro-using countries, which present some issues addressed later.


Short Comings
-------------

This application lacks some of the functionality desired in the specifications. I tried numerous approaches and searched Google many times, but was unable to get the following features working within the allotted time:

* On submitting the form, the form reloads without refreshing the page.
* Updating the charts without reloading
* Filtering the table
* One-database-per-user Multi-Tenancy

I tackled the form functionality from three angles: keeping the form within the index.html.erb file, rendering it as a partial and using AJAX, rendering it as a partial and using jQuery.

For the latter two I ran into a series of problems all relating to certain AJAX methods or the jQuery $.ajax() method not functioning. I tried installing the 'jquery-rails' gem, but this did not fix the problem and in fact destroyed the existing barchart functionality. I downloaded the 'rails.js' file, but this had no effect. No search result seemed to match what I needed; most examples when tried failed silently. What I would like to have done using jQuery is:

* Load the partial into an empty div (this did work)
* Use the .submit() function to catch and manipulate the form submission (this was where the problems lay)
* Empty the div containing the partial (never got executed due to jQuery errors in step above)
* Reload the partial into the div (same as above)

The inability to accomplish this feature naturally rendered the other two that depend on AJAX/jQuery incomplete as well.

As for the Multi-Tenancy: this application is currently working so that each user only sees their data and only affects their data. It is not however built so that each user is using their own database or even a copy of a table: users interact with a MyCollections table that tracks their collections.

Assumptions
-----------

The key assumption is that the users will want to visit and collect currency in every country, even if a country uses a currency they already have collected (eurozone nations, USD-using nations, etc). With more time I would have liked to make this a chooseable preference for users: if they go to Italy and collect the Euro, do they want all other Euro countries marked as visited? Or do they want to have to go to every other Euro-using country to collect the same currency.


