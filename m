Return-Path: <cygwin-patches-return-3229-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4805 invoked by alias); 24 Nov 2002 16:55:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4796 invoked from network); 24 Nov 2002 16:55:49 -0000
Message-Id: <3.0.5.32.20021124115540.00821c50@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 24 Nov 2002 08:55:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: More passwd/group patches
In-Reply-To: <20021124174709.E1398@cygbert.vinschen.de>
References: <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
 <3.0.5.32.20021124092120.00829650@mail.attbi.com>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3DDE3FB9.2AFAA199@ieee.org>
 <20021122154644.N1398@cygbert.vinschen.de>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3.0.5.32.20021124092120.00829650@mail.attbi.com>
 <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00180.txt.bz2

>
>I'm pretty sure it's related to setting myself->gid to the new
>DEFAULT_GID 401 in internal_getlogin.  It's perhaps a problem of the
>execution order.  However, I didn't look into the code so far since
>I'm busy with the sec_acl stuff.
>
I think his Windows user name isn't fergus. I will confirm 
that with him and submit a patch to reproduce exactly the old 
behavior in that case. 

Pierre
