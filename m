Return-Path: <cygwin-patches-return-3585-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8797 invoked by alias); 18 Feb 2003 22:08:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8780 invoked from network); 18 Feb 2003 22:08:57 -0000
Message-ID: <009c01c2d79a$552579d0$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <20030218221239.U46120-100000@logout.sh.cvut.cz>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Tue, 18 Feb 2003 22:08:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00234.txt.bz2

Two things - First:

Please, please don't make this the default! Once a file is sparsified, it
cannot be unsparsified except by copying the contents to a new file! This
seems like an optimization for a corner case is trying to cause a global
change.


And:

FSCTL_SET_SPARSE, used in the patch, is *not defined* in current w32api !!!


Max.


