Return-Path: <cygwin-patches-return-2506-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6736 invoked by alias); 24 Jun 2002 13:59:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6721 invoked from network); 24 Jun 2002 13:59:34 -0000
Message-ID: <3D1726E7.4EC19839@ieee.org>
Date: Mon, 24 Jun 2002 16:49:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Windows username in get_group_sidlist
References: <3.0.5.32.20020623235117.008008f0@mail.attbi.com> <20020624120506.Z22705@cygbert.vinschen.de> <20020624130226.GA19789@redhat.com> <20020624151450.G22705@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00489.txt.bz2

Corinna 

Now that get_group_sidlist () knows pw, it would be easy to
lookup the domain from passwd, instead of using LookupAccountSid.
This avoids over-the-network lookups for domain users.

I would actually read passwd by calling extract_nt_dom_user (),
modifying it to first read the domain from the passwd file, and 
if that fails, use LookupAccountSid [currently it tries 
LookupAccountSid first, getting the sid from passwd]. 

What do you think?

Pierre

Christopher Faylor wrote:
> What we really need is a "patch --fix-outlook-whitespace-botch".

Actually it was Eudora. Don't know what happened. I may have 
accidentally inserted a space.
