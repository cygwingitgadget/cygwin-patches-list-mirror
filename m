Return-Path: <cygwin-patches-return-3306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13484 invoked by alias); 11 Dec 2002 20:55:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13472 invoked from network); 11 Dec 2002 20:55:34 -0000
Message-ID: <3DF7A670.E7BA1862@ieee.org>
Date: Wed, 11 Dec 2002 12:55:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00257.txt.bz2

Christopher Faylor wrote:

> Shouldn't the global symbols be marked as "NO_COPY"?

I am not sure why things are as they are.
These symbols are initialized in do_global_ctors and never change.
Are the constructors running again after a fork? If so, NO_COPY is fine.
It would seem more efficient to copy than to rerun the constructors,
but I probably overlook some factors.

Pierre
