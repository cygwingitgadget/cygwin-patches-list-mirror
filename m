From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gareth Pearce" <tilps@hotmail.com>, <cygwin-patches@cygwin.com>
Cc: <cygwin-apps@sources.redhat.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 09 Nov 2001 20:01:00 -0000
Message-id: <033001c1699c$8bfa35d0$0200a8c0@lifelesswks>
References: <F174dfEtGrpUN7cLjHZ00022a02@hotmail.com>
X-SW-Source: 2001-q4/msg00190.html

cross-posted to cyg-apps. Please follow up on cyg-apps.

----- Original Message -----
From: "Gareth Pearce" <tilps@hotmail.com>


>
> hmm I hope you tested my patch, because although I tested it with no

I did. It seemed fine.

> problems, if your original patch didnt work - I wouldnt be supprised
that
> mine fails for the same reasons...

Yours works because the state _SKIP is already handled. There is no
state for 'keep' - just states for PREV/CURR/TEST && a test for those
being the current installed version.

> this was what I meant about not knowing
> why it worked... I also thought being set to unknown should break my
code
> ... but only realised that after having tested it and having had it
work jut
> fine...

Have you done much work with FSM's? set_action() is a fairly typically
FSM transition function.

> if you want it to say keep instead of skip ... under the way my patch
> works...

...

Yes, for the UI that will work, but the internal logic still needs to be
straightened out. Keeping the gui unfixed will act as a reminder :} .
Thoughts anyone? For the post-category release I'm hoping to have had a
chance to do something on this, so that the impact shouldn't be huge.

...

> would submit a patch, but NTFS on win2k being read only mounted is
stuffing
> me arround... and I couldnt test it here in debian anyway...

You might try plex86, I'm intending to use that for testing, if I can
ever get it to work.

> cyg-apps for setup/winsup directory stuff? hmmm thought I read
somewhere
> that was not right... anyway ... I can do that :P
> and cautious is a not wanting to tred on toes just yet :P I am sure
that
> will change after patch 3 or 4 ... :P

Oh, don't worry about my toes, on public lists I tend to wear steel caps
:}.

Rob
