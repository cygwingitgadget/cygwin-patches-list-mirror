Return-Path: <cygwin-patches-return-1746-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10080 invoked by alias); 18 Jan 2002 23:26:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10064 invoked from network); 18 Jan 2002 23:26:51 -0000
Date: Fri, 18 Jan 2002 15:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Christian LESTRADE <christian.lestrade@free.fr>
Cc: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Terminal input processing fix
Message-ID: <20020119002647.N11608@cygbert.vinschen.de>
Mail-Followup-To: Christian LESTRADE <christian.lestrade@free.fr>,
	cygpatch <cygwin-patches@cygwin.com>
References: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00103.txt.bz2

On Fri, Jan 18, 2002 at 10:59:10PM +0100, Christian LESTRADE wrote:
> Hello,
> 
> I would like to submit the following bugfix for theses bugs which appear
> mainly when using rxvt:
> 
> * Unable to effectively disable c_cc[] input chars processing (like ^C) 
> using
>   $ stty intr '^-'
>   When I type CTRL-SPACE, I enter a NULL char which is interpreted like ^C
> 
> * In raw mode (stty -icanon), the VDISCARD key (^O) should not be 
> recognized,
>   but should be passed to the application
> 
> This fix does not prevent rxvt to hang when typing ^O in cooked mode, but 
> only
> in raw mode, instead of always.

Thanks for that patch.  It looks good, even the ChangeLog.

Unfortunately your patch has a size which already requires us to
have a signed copyright assignment form from you as described on
http://cygwin.com/contrib.html. 

Please send the signed form by snail mail.  That will take some
days but it's required.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
