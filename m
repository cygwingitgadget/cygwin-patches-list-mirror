Return-Path: <cygwin-patches-return-4939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13959 invoked by alias); 10 Sep 2004 09:00:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13196 invoked from network); 10 Sep 2004 09:00:40 -0000
Date: Fri, 10 Sep 2004 09:00:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: Bob Byrnes <byrnes@curl.com>
Cc: cygwin-patches@cygwin.com
Subject: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040910090123.GV17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Bob Byrnes <byrnes@curl.com>,
	cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00091.txt.bz2

Bob,

this problem is easily reproducible with sftp.  It seems to be in some
way related to your pipe patch.

Due to speed considerations, Cygwin's implementation of OpenSSH uses
pipes for local IPC instead of socketpairs.  I switched back the whole
OpenSSH suite to use socketpairs and the problem disappears.  Getting
a 1.4Megs file takes about a minute when using pipes, a split second
when using socketpairs.  For some reason only receiving files is affected,
not sending.

Would you mind to have a look into that?  Or is that perhaps a problem
solved by one of your upcoming patches?


TIA,
Corinna


----- Forwarded message from Peter Siebold -----
> Date: Thu, 9 Sep 2004 13:46:50 -0700
> From: "Peter Siebold"
> Subject: 1.5.11-1: sftp performance problem
> To: Cygwin list
> 
> I updated to the newest version of cygwin dll on 9/7/4 and after sftp
> suffered performance issues when issuing a get on a large file.  File
> transfers now stall and do not complete.  After downgrading to version
> of 1.5.10-3 of cygwin sftp then it works fine.
> 
> Both configurations used openssh 3.9p1-1
> 
> This is the first time reporting a problem, so I hope I didn't miss
> anything.
> 
> -Pete
----- End forwarded message -----

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
