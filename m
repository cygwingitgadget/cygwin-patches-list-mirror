Return-Path: <cygwin-patches-return-7882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 812 invoked by alias); 10 May 2013 18:19:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 799 invoked by uid 89); 10 May 2013 18:19:56 -0000
X-Spam-SWARE-Status: No, score=-3.8 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 10 May 2013 18:19:56 +0000
Received: (qmail 80767 invoked by uid 13447); 10 May 2013 18:19:54 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 10 May 2013 18:19:54 -0000
Message-ID: <518D3A45.7000109@etr-usa.com>
Date: Fri, 10 May 2013 18:19:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: May I remove setup.xml and cygwin-ug.xml?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00020.txt.bz2

These files in winsup/doc appear to have been replaced by setup-net.xml 
and cygwin-ug-net.xml.  The Makefile doesn't use either of these as 
input to any of its outputs, and they're not referenced by any of the 
other input files.

Further, if you try to build a document from either of these, you get 
errors due to missing XML chunks.  (e.g. setup-reg.xml, referenced by 
setup.xml, doesn't exist.)

When I first discovered this, I thought for sure it meant I'd somehow 
screwed up the SGML to DocBook XML conversion, but ruled that out thus:

     $ grep -Rsl setup-reg winsup

If you do that to both the current tree and to a tree rolled back to 
before I got my commit bit, you find that only setup.{xml,sgml} contains 
that string.  It means the pre-Warren tree couldn't build documents from 
this file, either.

I'm not in any particular hurry to get rid of these files.  They only 
trouble they're causing is the same any clutter causes.  I want to make 
sure no one knows a reason either has to remain in existence before I 
nuke them.
