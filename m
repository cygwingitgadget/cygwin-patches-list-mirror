Return-Path: <cygwin-patches-return-3808-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4508 invoked by alias); 14 Apr 2003 10:06:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4445 invoked from network); 14 Apr 2003 10:06:14 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3E9A8812.1010002@gmx.net>
Date: Mon, 14 Apr 2003 10:06:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vaclav Haisman <V.Haisman@sh.cvut.cz>
CC: cygpatches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] enable -finline-functions optimization
References: <20030409203853.D67401-100000@logout.sh.cvut.cz>
In-Reply-To: <20030409203853.D67401-100000@logout.sh.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00035.txt.bz2

Vaclav Haisman wrote:
> Try -fkeep-inline-functions GCC flag instead.
> 

There are several inline functions in the DDK header files which are 
included from fhandler_serial that can't be kept.

Thomas

