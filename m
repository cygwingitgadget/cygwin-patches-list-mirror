Return-Path: <cygwin-patches-return-1475-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 21694 invoked by alias); 12 Nov 2001 13:16:57 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 21666 invoked from network); 12 Nov 2001 13:16:54 -0000
X-Apparently-From: <earnie?boyd@yahoo.com>
Message-ID: <3BEFCB8E.C0507FBD@yahoo.com>
Date: Tue, 02 Oct 2001 21:00:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: CP List <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Collins <robert.collins@itdomain.com.au>
CC: CP List <Cygwin-Patches@Cygwin.Com>,
 	Gareth Pearce <tilps@hotmail.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00007.txt.bz2

Robert Collins wrote:

> There was an earlier thread on skip vs keep, and what they mean.
>
> It was on cyg-apps IIRC.
>

That's fine, I half recall the thread and at the time didn't have time to
voice an opinion.  I know skip is intended for the not-installed packages
and keep is intended for the already-installed packages.  However, in the
current invocation skip is relative to both and IMO should still be relative
to both.  Skip for the not-installed means leave it not-installed (i.e.:
leave it as is) and skip for the already-installed means don't update what I
have (i.e.: leave it as is).  Setup does this now, there isn't a coding
change for it.  IMHO, keep should be removed in favor of skip.  As I said,
it may be too late to say anything but...

>
> Rob
>
> ----- Original Message -----
> From: "Earnie Boyd" <earnie_boyd@yahoo.com>
> ...
> > I've just downloaded with the current setup.exe and said "skip" to all
> > items I didn't want to bother at this time.  It worked properly.  If
> it's
> > not too late I'd like to say, just scrap the keep in favor of skip.

--
Earnie.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

