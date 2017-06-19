Return-Path: <cygwin-patches-return-8790-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15551 invoked by alias); 19 Jun 2017 18:47:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15159 invoked by uid 89); 19 Jun 2017 18:47:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,SPF_PASS,URI_HEX autolearn=no version=3.3.2 spammy=H*u:6.3, H*UA:6.3, afs, H*Ad:U*cygwin-patches
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 19 Jun 2017 18:47:38 +0000
Received: from [10.2.1.30] (c-73-240-197-175.hsd1.or.comcast.net [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id 82D6B160876	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2017 11:47:41 -0700 (PDT)
Message-ID: <59481C4D.5030206@pismotec.com>
Date: Mon, 19 Jun 2017 18:47:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v3
References: <594199C4.9080804@pismotec.com> <20170619114532.GC26654@calimero.vinschen.de>
In-Reply-To: <20170619114532.GC26654@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00061.txt.bz2


On 2017-06-19 04:45, Corinna Vinschen wrote:> Hi Joe,
> 
> As discussed in the previous iteration of this patch, this change
> results in nuking DT_UNKNOWN for reparse points we don't handle.  Still,
> IMHO, if we have reparse points we know nothing about, they should stay
> DT_UNKNOWN.
> 
> Why is changing them to DT_DIR/DT_REG a good idea?  Please convince me.

As coded, the patch makes the dentry.d_type field consistent with
S_ISREG and S_ISDIR on the results of lstat-ing the same name. This
seems correct to me, from the standpoint of avoiding compatibility
issues with any *nix application code that may look at the d_type
value and make some inference from it. I do not know of any specific
application examples where this is actually a problem.

My concern with DT_UNKNOWN for unknown reparse tags: it indicates
to cygwin applications and developers that reparse tags are an
extended file system node type enumeration. In general this is
incorrect. Reparse tags are a type of extended attribute that can be
attached to any regular NTFS file or directory. Reparse tags do not
necessarily do anything to prevent normal access to the
file/directory.

If you like, I will redo the patch to return dentry.d_type of
DT_UNKNOWN for files/directories with unknown reparse tags.
Let me know.


Reference, discussion of compat issue between msys-git (likely in
downstream cygwin code) and Windows server file deduplication:

http://git.661346.n2.nabble.com/FW-Windows-Git-and-Dedupe-td7579993.html
"The reparse point could be decoded as being a non-symlink reparse
item using; in those cases, treating the file as an ordinary file
would be appropriate."

Reference, blog post from AFS developer:

http://blog.secure-endpoints.com/2013/03/symbolic-links-on-windows.html
"For the longest time I resisted squatting on Microsoft's tag and
data structure but as long as FSCTL_GET_REPARSE_POINT returns the
IO_REPARSE_TAG_OPENAFS_DFS data many applications do the wrong
thing. There simply wasn't any choice from the perspective of
application compatibility."


Joe L.
