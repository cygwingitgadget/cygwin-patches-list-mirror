Return-Path: <cygwin-patches-return-7139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4769 invoked by alias); 14 Dec 2010 21:23:06 -0000
Received: (qmail 4747 invoked by uid 22791); 14 Dec 2010 21:23:03 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 14 Dec 2010 21:22:56 +0000
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de )	by mailout10.t-online.de with smtp 	id 1PScKk-0002XI-ED; Tue, 14 Dec 2010 22:22:54 +0100
Received: from [192.168.2.100] (rXIP5EZDZhYW1yx2IEgkIlXrWOhONUMScsjOn4W+kC2auPfohyJQgVsV7wRC8PDwdo@[79.224.122.94]) by fwd09.aul.t-online.de	with esmtp id 1PScKg-0y2z9k0; Tue, 14 Dec 2010 22:22:50 +0100
Message-ID: <4D07E02A.2020202@t-online.de>
Date: Wed, 15 Dec 2010 14:12:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de>
In-Reply-To: <20101211204653.GA26611@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------090507070906020801050706"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------090507070906020801050706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 4236

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
> On Dec 10 23:05, Christian Franke wrote:
>    
>> The ACL from Cygwin always contains the three (USER|GROUP|OTHER)_OBJ
>> entries. It might be existing practice elsewhere to return these
>> entries also in the default ACL. The attached patch adds these
>> entries with empty permissions if necessary.
>>
>> The patch would fix this rsync issue:
>> http://cygwin.com/ml/cygwin/2010-11/msg00429.html
>>
>> The logic for DEF_CLASS_OBJ is unchanged.
>>      
>
> This looks good, except that the faked default entries for group and
> other are set to 0.  That's rather unexpected. ...
>
> This is rather easy to fix (and you added comments in that place), ...

New patch attached.


>
> I'm not entirely sure yet, but maybe the acl function should not
> fake these default entries.  From my POV it seems a better approach
> if acl(SETACL) actually creates these entries if *any* default entry
> is in the incoming acl.  And, it should create these entries with
> useful permission values.  This seems to reflect the Linux behaviour
> much closer.  What do you think?

AFIAK a minimal ACL must contain the three entries u/g/o which are 
equivalent to the mode permission bits. The default ACL has likely the 
same requirement.

If this is the case, then I would suggest to do both:

1. Fake these entries in acl(GETACL) if required. This would ensure that 
the default ACL is complete even if the Windows ACL was not created by 
Cygwin.

2. Create these entries in acl(SETACL) if required. This would ensure 
that the following reasonable requirement holds if the Windows ACL was 
created by Cygwin before:

- "getfacl foo | setfacl -f - foo" should not change the (Windows) ACL 
of "foo".


>    Would you implement this?
>    

Yes, but may take some time.


> Btw., while testing your patch I found a bug in setfacl which disallowed
> to delete user/group-specific default entries.  I opted for rewriting the
> function which examines an incoming acl entry (getaclentry).  Would you
> mind to test this bit, too?  The new code accepts a trailing colon, but
> I think that's ok.  The SGI setfacl tool used on Linux is even more
> relaxed syntax-wise and also accepts trailing colons.
>    

I've done a few test, looks good.


An unrelated issue found during testing:

mkdir() may duplicate Windows ACL entries. Testcase (German XP SP3):

$ cd /tmp

$ mkdir 0

$ cd 0

$ setfacl -s 'u::rwx,g::r-x,o:---' .

$ xcacls .
C:\cygwin\tmp\0 SomeDomain\SomeOne:F
                 SomeDomain\Kein:R
                 Jeder:(special access:)
                       READ_CONTROL
                       FILE_READ_ATTRIBUTES

$ for d in 1 2 3 4; do mkdir -m 0750 $d; cd $d; xcacls .; done
[...]

C:\cygwin\tmp\0\1\2\3\4 SomeDomain\SomeOne:F
                         SomeDomain\Kein:R
                         Jeder:(special access:)
                               READ_CONTROL
                               SYNCHRONIZE
                               FILE_READ_ATTRIBUTES

                         Jeder:(OI)(CI)(IO)(special access:)
                                           READ_CONTROL
                                           SYNCHRONIZE
                                           FILE_READ_ATTRIBUTES

                         Jeder:(OI)(CI)(IO)(special access:)
                                           READ_CONTROL
                                           SYNCHRONIZE
                                           FILE_READ_ATTRIBUTES

                         Jeder:(OI)(CI)(IO)(special access:)
                                           READ_CONTROL
                                           SYNCHRONIZE
                                           FILE_READ_ATTRIBUTES

                         ERSTELLER-BESITZER:(OI)(CI)(IO)F
                         ERSTELLERGRUPPE:(OI)(CI)(IO)R
                         ERSTELLER-BESITZER:(OI)(CI)(IO)F
                         ERSTELLERGRUPPE:(OI)(CI)(IO)R
                         Jeder:(OI)(CI)(IO)(special access:)
                                           READ_CONTROL
                                           SYNCHRONIZE
                                           FILE_READ_ATTRIBUTES


Problem in security.cc:alloc_sd() ?

Christian


--------------090507070906020801050706
Content-Type: text/x-patch;
 name="sec_acl-default-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sec_acl-default-2.patch"
Content-length: 2179

diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
index 24f2468..72d310e 100644
--- a/winsup/cygwin/sec_acl.cc
+++ b/winsup/cygwin/sec_acl.cc
@@ -357,11 +357,13 @@ getacl (HANDLE handle, path_conv &pc, int nentries, __aclent32_t *aclbufp)
 	  else if (ace_sid == well_known_creator_group_sid)
 	    {
 	      type = GROUP_OBJ | ACL_DEFAULT;
+	      types_def |= type;
 	      id = ILLEGAL_GID;
 	    }
 	  else if (ace_sid == well_known_creator_owner_sid)
 	    {
 	      type = USER_OBJ | ACL_DEFAULT;
+	      types_def |= type;
 	      id = ILLEGAL_GID;
 	    }
 	  else
@@ -388,13 +390,38 @@ getacl (HANDLE handle, path_conv &pc, int nentries, __aclent32_t *aclbufp)
 		getace (lacl[pos], type, id, ace->Mask, ace->Header.AceType);
 	    }
 	}
-      /* Include DEF_CLASS_OBJ if any default ace exists */
-      if ((types_def & (USER|GROUP))
-	  && ((pos = searchace (lacl, MAX_ACL_ENTRIES, DEF_CLASS_OBJ)) >= 0))
+      if (types_def && (pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) >= 0)
 	{
-	  lacl[pos].a_type = DEF_CLASS_OBJ;
-	  lacl[pos].a_id = ILLEGAL_GID;
-	  lacl[pos].a_perm = S_IROTH | S_IWOTH | S_IXOTH;
+	  /* Ensure that the default acl contains at
+	     least DEF_(USER|GROUP|OTHER)_OBJ entries.  */
+	  if (!(types_def & USER_OBJ))
+	    {
+	      lacl[pos].a_type = DEF_USER_OBJ;
+	      lacl[pos].a_id = uid;
+	      lacl[pos].a_perm = lacl[0].a_perm;
+	      pos++;
+	    }
+	  if (!(types_def & GROUP_OBJ) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_GROUP_OBJ;
+	      lacl[pos].a_id = gid;
+	      lacl[pos].a_perm = lacl[1].a_perm;
+	      pos++;
+	    }
+	  if (!(types_def & OTHER_OBJ) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_OTHER_OBJ;
+	      lacl[pos].a_id = ILLEGAL_GID;
+	      lacl[pos].a_perm = lacl[2].a_perm;
+	      pos++;
+	    }
+	  /* Include DEF_CLASS_OBJ if any named default ace exists.  */
+	  if ((types_def & (USER|GROUP)) && pos < MAX_ACL_ENTRIES)
+	    {
+	      lacl[pos].a_type = DEF_CLASS_OBJ;
+	      lacl[pos].a_id = ILLEGAL_GID;
+	      lacl[pos].a_perm = S_IROTH | S_IWOTH | S_IXOTH;
+	    }
 	}
     }
   if ((pos = searchace (lacl, MAX_ACL_ENTRIES, 0)) < 0)

--------------090507070906020801050706--
