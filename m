Return-Path: <cygwin-patches-return-4010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8902 invoked by alias); 14 Jul 2003 17:32:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8885 invoked from network); 14 Jul 2003 17:31:58 -0000
Message-ID: <3F12E948.82BBB05C@ieee.org>
Date: Mon, 14 Jul 2003 17:32:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com> <20030714170539.GE12368@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00026.txt.bz2

Corinna Vinschen wrote:
> 
> Hi Pierre,
> 

> I've applied this patch.  I've just changed the code to use
> INVALID_HANDLE_VALUE instead of NULL throughout.
> 
> Thanks,
> Corinna
> 
Hi Corinna,

I was going to send you the modified patch tonight, with some extra
cleanup added.

After researching the issue, all cygwin routines I could find (not
only those ntsec related) initialize their handles to NULL, except
subauth() and create_token(). Those exceptions make sense because 
those two must return INVALID_HANDLE_VALUE on error.

The patch itself avoids initializing any handle (avoiding ambiguity), 
except the usual automatic initialization to 0 of the cygheap stuff.  

Do you want my patch anyway (reverting what you have just applied), 
or do we leave things as they are?

Pierre
