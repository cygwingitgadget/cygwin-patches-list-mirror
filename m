Return-Path: <cygwin-patches-return-2952-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19476 invoked by alias); 11 Sep 2002 13:17:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19462 invoked from network); 11 Sep 2002 13:17:05 -0000
Message-ID: <3D7F4284.46484222@ieee.org>
Date: Wed, 11 Sep 2002 06:17:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: initgroups
References: <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com> <20020911123808.Q1574@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00400.txt.bz2

Corinna Vinschen wrote:

> > P.S.: Why is there a need to define ILLEGAL_GID? It
> > is never used to set a value.
> 
> It's used in chown_worker() to check against gid -1 on input.

O.K, it's used to check against -1, but -1 is never used as
a reserved value. In other words, why is the largest possible
gid value forbidden? 

Pierre
