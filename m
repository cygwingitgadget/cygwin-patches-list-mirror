Return-Path: <cygwin-patches-return-3158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2035 invoked by alias); 12 Nov 2002 19:44:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2026 invoked from network); 12 Nov 2002 19:44:40 -0000
Message-ID: <3DD15A2F.B79E5376@ieee.org>
Date: Tue, 12 Nov 2002 11:44:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: patch 3: sshd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00109.txt.bz2


Corinna Vinschen wrote:
> 
> On Wed, 06 Nov 2002 11:36:31 -0500, Pierre A. Humblet wrote:
> > Currently setuid on Win95/98/ME always returns success
> > but does not change the uid. That confuses some programs
> > that verify if the setuid has really succeeded.
> >
> > It is literally a two line change in Cygwin to fix
> > that, but unfortunately changing uids breaks sshd
> > on Win95/98/ME.
> 
> Can we really do this?  Doesn't that potentially break something?

It makes Cygwin more unix-like, so it should be OK.
I tested it and the only problem I found was sshd.

Pierre
