From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>, "cygwin-patches" <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - change Prev, Curr, Test Radio Buttons to a Single PushButton
Date: Sun, 11 Nov 2001 14:47:00 -0000
Message-ID: <040301c16b03$0d077130$0200a8c0@lifelesswks>
References: <VA.000009be.0055f8df@thesoftwaresource.com> <02a401c1691d$0b247030$0200a8c0@lifelesswks> <VA.000009c6.0059ec68@thesoftwaresource.com>
X-SW-Source: 2001-q4/msg00196.html
Message-ID: <20011111144700.JTWbu0bGWbqmX7eMQGgcALJQGbNnAiZCFtSFmGhIkXg@z>

----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>
>
> The ultimate goal was to have the ability to hit a push button that
would cycle
> through "Curr", "Prev", "Test" versions as well as options for
> "Keep/Skip","Uninstall","Redownload","Reinstall" and "Sources" and
have it
> apply to the whole list of packages and not have to do them
individually.
> Unfortunately, with all the new changes that occurred in setup with
the
> categories and dependencies my understanding of all the trust logic
took a
> nosedive and any code I was working on/understood in this area
crumbled.

Yeah, the categories and dependencies made big changes to the internal
logic - as you'd expect. I'm hoping to fiddle this in the near future
and make it a little easier to hack on.

Rob
