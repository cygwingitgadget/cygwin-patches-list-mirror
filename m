Return-Path: <cygwin-patches-return-2702-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30125 invoked by alias); 24 Jul 2002 10:35:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30109 invoked from network); 24 Jul 2002 10:35:32 -0000
Message-ID: <3D3E8216.4010304@netscape.net>
Date: Wed, 24 Jul 2002 03:35:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
References: <20020724073803.17255.qmail@sources.redhat.com> <145518762130.20020724122337@logos-m.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00150.txt.bz2

egor duda wrote:

>Hi!
>
>[...]
>+       55: Export fcloseall, fcloseall_r.
>      */
>
I'm sorry that I didn't bump the API in my patch, but I wasn't sure what 
the guidelines were for this.  Should it be done every time a new symbol 
is added?  Sorry if this is a rule I should already know.

Cheers,
Nicholas
