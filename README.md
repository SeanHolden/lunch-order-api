###What is this?
A custom Slack bot for ordering sandwiches!

###Wait, what?
My office is across the road from a delicious sandwich shop known as "The Little Hatch". They prepare freshly made hot and cold sandwiches. They have a mobile number which enables people to text in their order in advance, so it is ready to pick up when they get there.
This app allows for slack users to type, for example, `/hatch chicken sandwich with mayo` and automatically have that ordered for them. No need for manual texting. No need to ask fellow colleagues if they want to add their order in with yours, etc. You just order your sandwich and that's it!

###How?
When a user types the command, their order is added to a database. At a scheduled time, all orders from that day are formatted into a list and sent automatically by SMS using [Twilio's SMS API](https://www.twilio.com/). It then takes advantage of [Slack's incoming webhook API](https://api.slack.com/incoming-webhooks) to return the SMS status and any replies, back into the Slack channel so users can see if everything is okay with their order.

###What happens if I place an order after the SMS has been sent?
You get a nice message to explain that you are too late to order, but it also gives you the mobile number of the shop if you would like to place a manual order yourself.

###Does it do anything else?
Other commands are as follows:

`/hatch menu` => returns a menu into the slack channel that only you can see.

`/hatch cancel` => cancel your order before the SMS deadline if you changed your mind.

__Users with special privileges can also do the following:__

`/hatch cancel someusername` => users with special privileges can cancel another user's order (e.g. someone places a "joke" order in the hope they can get a rude word sent to the sandwich shop... it happens!)

`/hatch check` => get a list of all orders placed today so far

`/hatch reply insert_reply_here` => for example, if the shop reply to an order to say they are out of chicken, you can reply to say "ok, beef is fine"

###Further development?
Well, there's been talk of building Paypal integration and also programming a drone to make the deliveries to avoid having to leave your chair at all!
Unfortunately this will probably never happen as there is only so much time I am willing to put into a sandwich ordering app... but hey, I can dream.

###I have an idea for a new feature!
I don't really want to spend any more time on this as I have other projects I am working on.

However... __Pull requests are always welcome!__
