Return-Path: <cygwin-patches-return-1610-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30587 invoked by alias); 19 Dec 2001 12:27:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30572 invoked from network); 19 Dec 2001 12:27:08 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 07 Nov 2001 17:13:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEPOCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <040a01c18880$877afbe0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00142.txt.bz2

> From: cygwin-patches-owner@cygwin.com
> [mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
> Sent: Wednesday, December 19, 2001 5:30 AM
> To: Gary R. Van Sickle; cygwin-patches@sourceware.cygnus.com
> Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly
> diffed.
>
>
> Ok, I'll get nitty-gritty now.
>
> ChangeLog presentation:
> :The changelog is formatted wrongly - you have extra lines.
> :When you have
> (foo): Did bar.
> (foo): Did barf.
> write it as
> (foo): Did bar.
> Did barf.

I see one instance of that, is that correct?

> :in the main entry you have a tab halfway through the line
>

Not any more. ;-)

> Regarding the patch:
> :Please remove the #if 0'd items. If its a mistake to remove them, then
> we can get them back from CVS.

Alright.

> :Please remove your package_meta.h (sdesc) workaround. It's not the
> right answer. (We can discuss what is instead if you like).

Alright.  I see that upset or whatever's feeding it has been fixed, so that
should no longer be necessary for what I'm concentrating on right now.

> :lets assume that chooser will subsume choose, can you please make the
> changes direct to choose. (I don't really want a short lived migration
> file - it seems pointless). (remember - CVS is smart). If you think
> there really will be two classes for this (other than the working inside
> classes) then leave it as is.
>

Like I said, I don't know what the answer to this one is.  I do know that simply
putting choose in the property sheet will make all the other pages ridiculously
huge (they all end up being the size of the biggest one), and is not an option
because of that.  If the sheet can be resized programmatically on Win95 on, I
can put it in and adjust it that way (which I think would be the best solution),
but if not we'll need the two sheets, one basically as a "filler" (as I have it
now).  But even if the first way is possible, we're talking considerably more
time and work.  What I've got now works at least as good as it did before WRT
the chooser, so I see no reason for this to hold up the rest of the changes.
And you've already taken me to task on the size and scope of this patch ;-).

> Cheers,
> Rob
>

--
Gary R. Van Sickle
Brewer.  Patriot.
