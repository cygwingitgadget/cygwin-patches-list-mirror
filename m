Return-Path: <cygwin-patches-return-3915-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9481 invoked by alias); 27 May 2003 07:47:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9450 invoked from network); 27 May 2003 07:47:17 -0000
Date: Tue, 27 May 2003 07:47:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Proposed change for Win9x file permissions...
Message-ID: <20030527074715.GA19957@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00142.txt.bz2

On Fri, May 23, 2003 at 05:01:43PM -0400, Bill C. Riemers wrote:
>   The first one is to fhandler_disk_file.cc.
> This changes the fstat()
> function to show Win9x permissions masked by the "umask".  This is the same
> thing early versions of
> the Linux FAT driver did, before "umask" was added as a mount option.
> Obviously that would be the better solution for Cygwin as well.  However, I
> decided try the simpler option of just using the normal umask first.

Applied.  Just two hints: Please add a ChangeLog entry next time and
please use (cvs) diff -up format for patches.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
