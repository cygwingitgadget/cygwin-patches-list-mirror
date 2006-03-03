Return-Path: <cygwin-patches-return-5790-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28076 invoked by alias); 3 Mar 2006 16:37:18 -0000
Received: (qmail 28065 invoked by uid 22791); 3 Mar 2006 16:37:17 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 16:37:16 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 3 Mar 2006 16:37:13 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
Date: Fri, 03 Mar 2006 16:37:00 -0000
Message-ID: <042501c63ee0$b990d170$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.63.0603031058150.9494@access1.cims.nyu.edu>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00099.txt.bz2

On 03 March 2006 16:02, Igor Peshansky wrote:


>> I'm not quite sure how to handle the mapping from file types to
>> registry key types, but there might be some simple way which I'm just
>> too blind to see.
> 
> Hmm, there is currently no way for the programs to find out the registry
> key type, unless we introduce new functionality into stat() or something.
> 
> As it is, why would the programs need to know the key type, anyway?  

  Because they aren't writing it for their own benefit, but in order for it to
be read by some other app that requires it to be of a specific type.

> They
> just write the data, and fhandler_registry takes care of converting it to
> the right format (using arbirtary conventions of some sort).  The only
> potential problems are REG_MULTI_SZ and REG_EXPAND_SZ (in the former case
> it's a question of picking a string delimiter, and in the latter it's
> about annotating expandable values).
> 
> Am I missing something?

  You're thinking of the registry as some place where a program puts its own
private data and reads it back and therefore assuming that it doesn't matter
what actually is /in/ the registry as long as the program gets back the exact
same stuff it put in there, but sometimes programs want to alter or set
registry values for external apps that require a specific type.  If cygwin
chose a type and didn't provide a way to specify, this feature would be of
much more limited use as you couldn't use it to modify an existing value
because cygwin might decide to write it back as a different type and break
whatever-it-was that depended on it.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
