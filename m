Return-Path: <cygwin-patches-return-2348-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20221 invoked by alias); 6 Jun 2002 14:43:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20196 invoked from network); 6 Jun 2002 14:43:34 -0000
Message-ID: <3CFF761E.720EC8C6@ieee.org>
Date: Thu, 06 Jun 2002 07:43:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
References: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com> <20020606131834.H30892@cygbert.vinschen.de> <3CFF6CB2.66B80261@ieee.org> <20020606162548.E22789@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00331.txt.bz2

Corinna Vinschen wrote:

> You're right but it doesn't matter since I have to open the token
> anyway since I need the primary group which isn't available at that
> point.

Yes, but you open, read and close it and passwd.cc, and then open, read
and close it in grp.cc. 

> It's faster than strcasecmp.
Thanks, I will use it instead.

Pierre
