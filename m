Return-Path: <cygwin-patches-return-3747-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8606 invoked by alias); 26 Mar 2003 20:22:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8597 invoked from network); 26 Mar 2003 20:22:16 -0000
Date: Wed, 26 Mar 2003 20:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] performance patch for /proc/registry -- version 2
Message-ID: <20030326202213.GZ23762@cygbert.vinschen.de>
Mail-Followup-To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
References: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net> <3E820411.1020100@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E820411.1020100@hekimian.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00396.txt.bz2

On Wed, Mar 26, 2003 at 02:48:33PM -0500, Joe Buehler wrote:
> Chris January wrote:
> 
> >How common are ACLs > 4096 bytes? Could you try calling RegKeyGetSecurity
> >twice? First with a length of 0. Then RegKeyGetSecurity will set length to
> >the required buffer size which you can allocate dynamically using new.
> 
> Whatever Corinna or Christopher want me to do is fine with me.  I just
> copied some code from elsewhere in Cygwin.

It's ok to use the 4K for now.  I'm sure there are more dangerous places
in the code where we're currently using a 4K buffer for SDs or ACLs as well.

However... am I doing something wrong?  I'm trying to find out what the
performance improvement is on my XP box and both versions of the DLL
(w/ and w/o your patch) are running 7.5 minutes for 

  ls -lR /proc/registry > /dev/null

Or is that only a problem on older systems?  You're running NT4SP5, right?

Other than that your patch looks fine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
