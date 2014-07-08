---
type: article
date: 2013-07-26
title: Reddit Spellchecking Bot
---

I&rsquo;ve created Reddit scripts in the past, before the [API](http://www.reddit.com/dev/api) was well documented, but never an actual bot.

I heard about [PRAW](https://praw.readthedocs.org/en/latest/index.html) and really wanted to create a bot, so I started with the simplest: a spell-checking bot name [MayhapsYouMeant](http://www.reddit.com/user/MayhapsYouMeant). It&rsquo;s not so easy to create a list of misspellings since one misspelled word might have multiple corrections. But out of the hundreds of comments every minute, I&rsquo;m bound to find misspellings even with a short list.

Some people really get angry when you correct them. I didn&rsquo;t make this to feel better than them. I think it&rsquo;s a good thing when I get corrected. I can&rsquo;t tell how many times I&rsquo;ve spelled _seams_ when I meant _seems_ before somebody corrected me. A spell-checker won&rsquo;t tell you that because _seams_ is a real word.

The Python script simply gets about 100 of the newest comments every 30 seconds and checks if there are any clear-cut misspellings. Every 5 minutes I post the most recent. Since people don&rsquo;t like to be corrected I thought it best to be apologetic so my text was:

> I&rsquo;m terribly sorry, but did you mean &ldquo;{CORRECT}&rdquo; instead of &ldquo;{WRONG}&rdquo;?

People didn&rsquo;t like the initial comments. So I thought I should be even _more_ apologetic&hellip; and also less monotonous. I remembered the [Kant Generator](http://www.diveintopython.net/xml_processing/) from my early Python days and created this [grammar file](http://www.reddit.com/r/TheGirlSurvivalGuide/comments/1i8gzk/is_nair_a_good_alternative_to_shaving/cb2b7mt) for it.

What I learned from this is that the journey of programming the bot (well more of a walk) isn&rsquo;t the interesting part, the responses you get are. I&rsquo;ll split them the traditional way.

### The ugly

Some people don&rsquo;t believe it&rsquo;s a bot, but rather that I&rsquo;m a loser with nothing better to do.

The bot can&rsquo;t detect a user&rsquo;s intentions so it sometimes ends up correcting people when [they are joking](http://www.reddit.com/r/Music/comments/1idodh/kanye_wests_new_shirt_is_a_120_plain_white_tshirt/cb3ixvp?context=3):

> THIS IS NOT THE TIME GODDAMMIT, HE/SHE IS TRYING TO BE WITTY. JESUS FUCK

I didn&rsquo;t check for block quotes, so it was [correcting the wrong people](http://www.reddit.com/r/truegaming/comments/1i83fx/computer_collectible_card_games/cb1w2vw?context=3).

### The good

> You&rsquo;re adorable. &mdash; [time146](http://www.reddit.com/r/AskReddit/comments/1i8k07/if_you_woke_up_one_day_in_an_insane_asylum_what/cb29so9)
> awww, so polite and apologetic. what an adorable bot. &lt;3 &mdash; [ekrej](http://www.reddit.com/r/TwoXChromosomes/comments/1ibbgy/allie_finished_it_hyperbole_and_a_half_book_comes/cb306go)
> This better become a thing, i want to see you around more. I enjoyed that vey much. &mdash; [mechanistic6](http://www.reddit.com/r/IAmA/comments/1i82qt/iama_request_person_who_animates_boob_physics_in/cb20axc)

Everybody seems to [think I&rsquo;m Canadian](http://www.reddit.com/r/everymanshouldknow/comments/1ibmnq/emsk_how_to_take_out_a_wasp_nest_with_a_cup_of/cb2z5wb?context=2):

> Canadian bot?

### The bad

Some people [really, really hate it](http://www.reddit.com/r/relationship_advice/comments/1i86h0/boyfriend_23m_spends_money_carelessly_considering/cb1xx4k?context=4):

> it&rsquo;s funny that the bot had to correct relevant when the stupid bot itself is never relevant to any post. and prefacing a bot with being sorry, wtf is that about? no, if you were sorry, you wouldn&rsquo;t be here. I&rsquo;m terribly sorry but here is a bullet in the head. see how that works? just freaking park the thing and chat on reddit like a normal person. or make a circle jerking bot subreddit where everyone&rsquo;s bots jerk to each other.

Body builders [don&rsquo;t like to be told](http://www.reddit.com/r/bodybuilding/comments/1i9p65/mark_wahlberg_project_pain_and_gain/cb2cqbk?context=3) what the correct spelling of _dumbbell_ is.

### Conclusion

All in all, the bot is making way more comments than I could keep up with and it&rsquo;s getting a lot of karma. It took me about 2 years to get as much karma on my first Reddit account as the bot did in 3 days.

I&rsquo;m no longer running it now since I want to improve it and put it on GitHub.
