From: "Gareth Pearce" <tilps@hotmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 09 Nov 2001 19:14:00 -0000
Message-id: <F174dfEtGrpUN7cLjHZ00022a02@hotmail.com>
X-SW-Source: 2001-q4/msg00187.html

>
>----- Original Message -----
>From: "Gareth Pearce" <tilps@hotmail.com>
>To: <robert.collins@itdomain.com.au>; <cygwin-patches@cygwin.com>
>
>
>...
> > Would have submited another go ... but what you have done looks great
>(A
> > more significant change then I would have submited, but then I am in
>newbie
> > cautious mode), and I am in the middle of a 336meg download of debian
>
>I've put your patch into the categories branch, and into HEAD.

hmm I hope you tested my patch, because although I tested it with no 
problems, if your original patch didnt work - I wouldnt be supprised that 
mine fails for the same reasons... this was what I meant about not knowing 
why it worked... I also thought being set to unknown should break my code 
... but only realised that after having tested it and having had it work jut 
fine...

if you want it to say keep instead of skip ... under the way my patch 
works...

in choose_caption
I think
    case ACTION_SKIP:
      if (!pkg->installed)
        return "Skip";
      else
        return "Keep";

should do it... since theres no actual difference between the actions 
internally,
ofcourse your fix that you had before is much cleaner ... and I really 
thought it would have worked if mine did ... prehaps a simple logic tweak 
would fix it... ie for instance would that loop ever set the value to 
ACTION_SAME ? ... I am thinking that it wouldnt... but I dont have your code 
right in front of me ...


fixing it if unkown doesnt work should be as simple as if 
(!pkg->installed_ix ||pkg->install_ix==unkownConstantThingie) isntead of 
just installed_ix check...

would submit a patch, but NTFS on win2k being read only mounted is stuffing 
me arround... and I couldnt test it here in debian anyway...

>
>As for being cautious .... I'll accept any patch, big or small, that
>a) is inline with the setup.exe goals. If in doubt the issue can be
>discussed to it's death on cyg-apps.
>b) is coded well. return values checked, snprintf instead of sprintf
>etc.
>c) is designed well (IOW doesn't make the internal maintenance harder).
>
>I understand not wanting to spend a lot of time on a big patch, just to
>get the patch rejected, so discussing the concept first on cyg-apps is
>usually a good idea for non-obvious or structural work.

cyg-apps for setup/winsup directory stuff? hmmm thought I read somewhere 
that was not right... anyway ... I can do that :P
and cautious is a not wanting to tred on toes just yet :P I am sure that 
will change after patch 3 or 4 ... :P

Gareth


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
