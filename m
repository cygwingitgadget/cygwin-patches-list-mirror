Return-Path: <cygwin-patches-return-3955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26806 invoked by alias); 13 Jun 2003 00:57:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26715 invoked from network); 13 Jun 2003 00:57:39 -0000
Message-Id: <3.0.5.32.20030612205749.0080c5e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Fri, 13 Jun 2003 00:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Problems on accessing Windows network resources
In-Reply-To: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00182.txt.bz2

Corinna,

consider the issue with cygwin_set_impersonation_token()
solved. I found a nice way out, leaving it void. I will
send a patch after the current one is taken care of.

Pierre
