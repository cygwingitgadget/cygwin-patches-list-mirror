Return-Path: <cygwin-patches-return-4952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6406 invoked by alias); 11 Sep 2004 13:03:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6392 invoked from network); 11 Sep 2004 13:03:51 -0000
Date: Sat, 11 Sep 2004 13:03:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040911130435.GC17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040910204850.AFD08E538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910204850.AFD08E538@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00104.txt.bz2

On Sep 10 16:48, Bob Byrnes wrote:
> >              ...  I don't use sftp much, but we pump *enormous* amounts
> > of data through sshd otherwise, so it's odd that I haven't noticed any
> > performance impact.

scp is really old stuff, basically mimicing rcp.
Tip of the day:

	cd $SOURCEDIR
	tar cvf - . | ssh $DESTHOST 'cd $DESTDIR && tar xf -'

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
