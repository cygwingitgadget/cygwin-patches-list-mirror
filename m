Return-Path: <cygwin-patches-return-2538-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11526 invoked by alias); 29 Jun 2002 07:36:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11508 invoked from network); 29 Jun 2002 07:36:19 -0000
Date: Sat, 29 Jun 2002 01:44:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020629093616.C1247@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003601c21e94$064fc780$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00521.txt.bz2

On Fri, Jun 28, 2002 at 09:07:42PM +1000, Robert Collins wrote:
> Chris/Corinna, why do you want to avoid *new* functionality (especially
> with security complications) using the cygserver?

Basically, I don't like that sshd might depend on a running cygserver.
If the implementation only works with a server process as for SysV shared
memory, that's ok.  But if it's possible to get that working w/o the
cygserver, I'd prefer that.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
