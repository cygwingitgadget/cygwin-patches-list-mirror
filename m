Return-Path: <cygwin-patches-return-3177-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7445 invoked by alias); 14 Nov 2002 19:57:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7430 invoked from network); 14 Nov 2002 19:57:18 -0000
Date: Thu, 14 Nov 2002 11:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114205715.O10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114202105.N10395@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00128.txt.bz2

On Thu, Nov 14, 2002 at 08:21:05PM +0100, Corinna Vinschen wrote:
> is_grp_member() calls getgroups32() only for the current user and
> scans passwd and group otherwise, trying to be more efficient.

Btw., it "feels" faster now to call ls -l...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
