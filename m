Return-Path: <cygwin-patches-return-1755-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24462 invoked by alias); 21 Jan 2002 14:41:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24417 invoked from network); 21 Jan 2002 14:41:03 -0000
Date: Mon, 21 Jan 2002 06:41:00 -0000
From: Dennis Vshivkov <walrus@amur.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] No codepage translation in cygwin console
Message-ID: <20020121174058.B31464@amur.ru>
References: <20020115194622.A3962@amur.ru> <20020119002711.A24934@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020119002711.A24934@cygbert.vinschen.de>; from cygwin-patches@cygwin.com on Sat, Jan 19, 2002 at 12:27:11AM +0100
X-SW-Source: 2002-q1/txt/msg00112.txt.bz2

On Sat, Jan 19, 2002 at 12:27:11AM +0100, Corinna Vinschen wrote:

> >     If con-asis suboption is specified, console input and output goes
> > unchanged.  Hope this helps someone.
> 
> actually your patch seems to be useful when having to switch
> between different codepages.
> 
> But I have two problems with that patch:
> 
> - First of all, your patch isn't `trivial' enough so that we
>   can incorporate it without getting a signed copyright assignment
>   form from you as described on http://cygwin.com/contrib.html.
>   Please send us the signed form via snail mail.  As soon as we
>   received it we can use your patch.

    Ok, I've printed the assignment and will send it ASAP.

> - Your ChangeLog entry isn't correctly indented.  And please use
>   your real name, not a pseudonym.

    Ok.  Do I have to correct and resend it right away or it's better to wait
until the assignment is received?

> Otherwise I'd be happy to apply your patch to Cygwin.

    Thanks.

-- 
/Awesome Walrus <walrus@amur.ru>
