Return-Path: <cygwin-patches-return-3263-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29168 invoked by alias); 2 Dec 2002 16:32:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29080 invoked from network); 2 Dec 2002 16:32:33 -0000
Message-ID: <3DEB8ABD.80309@ece.gatech.edu>
Date: Mon, 02 Dec 2002 08:32:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00214.txt.bz2

Two issues:  (1) the licensing "problem", (2) the advisability of mingw 
pseudo-reloc.  Item (1) here, item (2) in a separate message.

CF> I'm not sure that public domain is going to work with the cygwin 
license.

ED> IANAL, but i can't see why not.

Here's why:  in order for code to be incorporated into cygwin, copyright 
ownership -- not merely a "license to use" -- must be assigned to Red 
Hat.  Red Hat then has the authority to release the code under whatever 
license it wants: totally proprietary non-GPL, if it wants to.  Red Hat 
could even release that code under a license that says "Everyone on the 
planet can freely use this code -- except for Egor Duda" -- even though 
Egor Duda originally contributed the code.

See, because you must assign *ownership* of the code to Red Hat, you no 
longer have ANY rights or priveleges with respect to that code.

So, if it is to be included in Mingw, then *Red Hat* must explicitly 
release that part of the code under a public domain license, not you -- 
assuming it goes into cygwin "first".

OTOH, if you, Egor Duda, do NOT assign ownership to Red Hat, but instead 
release the code as public domain FIRST, then mingw is free to take it. 
  Also, Red Hat is free to take it as well -- but they do not have 
"ownership" of the code; they simply are using it as they would any 
other public domain code.  Which means Red Hat has the right to 
re-release it under their proprietary cygwin license and under the GPL.

But, I am not sure how your (Egor's) pre-existing "assignment form for 
continuing contributions" affects this.  Does the assignment kick in 
automatically, since this was developed against the cygwin source dist?

So, IANAL, but it seems that "the right way" to do this is for you to 
release the code as public domain, and then for someone else -- cgf? -- 
to adapt it to the cygwin build system for "assimilation".

--
Chuck
