Return-Path: <cygwin-patches-return-3342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13557 invoked by alias); 17 Dec 2002 15:24:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13546 invoked from network); 17 Dec 2002 15:24:35 -0000
Message-ID: <3DFF41DC.BB578807@ieee.org>
Date: Tue, 17 Dec 2002 07:24:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de> <3DFE151D.B657F3EF@ieee.org> <3DFE1867.1242AEFC@ieee.org> <3DFE1AD7.76CA224D@ieee.org> <20021216193940.I19104@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00293.txt.bz2

Corinna,

After thinking more about it, I am afraid there is a basic
problem with how merging is done in setacl. Consider the 
following double matching case, where entry 1 matches 4 and 
entry 3 matches 5. 

0 user::rwx
1 user:testuser:r--
2 group::r-x
3 other:rw-
4 default:user:testuser:r--
5 default:other:rw-

After 1 is matched with 4, the type of 4 is reset to 0, to
"eliminate the corresponding default entry".
When searchace () is then called for 3, the search will stop
on 4, and not reach 5, because type == 0 is a wildcard.
This has been verified, see below.

A solution is to invalidate the type of entry 4 after matching, 
instead of resetting it to 0.
The patch below is incremental to what I sent last night.

Pierre

2002/12/17  Pierre Humblet  <pierre.humblet@ieee.org>

	* sec_acl.cc (setacl): Invalidate the a_type of matching
	default entries, instead of clearing it. 

--- sec_acl.cc.orig     2002-12-17 09:52:19.000000000 -0500
+++ sec_acl.cc  2002-12-17 09:52:29.000000000 -0500
@@ -145,8 +145,8 @@ setacl (const char *file, int nentries, 
          && aclbufp[i].a_perm == aclbufp[pos].a_perm)
        {
          inheritance = SUB_CONTAINERS_AND_OBJECTS_INHERIT;
-         /* This eliminates the corresponding default entry. */
-         aclbufp[pos].a_type = 0;
+         /* This invalidates the corresponding default entry. */
+         aclbufp[pos].a_type = USER|GROUP;
        }
       switch (aclbufp[i].a_type)
        {



***********************************************88
/> uname -a
CYGWIN_NT-4.0 PHumblet 1.3.17(0.67/3/2) 2002-11-27 18:54 i686 unknown
/> setfacl -s u::rwx,u:testuser:r--,g::r--,o:rw-,d:u:testuser:r--,d:o:rw- abcd
/> cacls abcd
e:\abcd DOMAIN\PHumblet:F 
        PHumblet\testuser:(OI)(CI)(special access:)
                                  READ_CONTROL
                                  SYNCHRONIZE
                                  FILE_GENERIC_READ
                                  FILE_READ_DATA
                                  FILE_READ_EA
                                  FILE_READ_ATTRIBUTES
 
        DOMAIN\Clearusers:(special access:)
                               READ_CONTROL
                               SYNCHRONIZE
                               FILE_GENERIC_READ
                               FILE_READ_DATA
                               FILE_READ_EA
                               FILE_READ_ATTRIBUTES
 
        Everyone:(special access:)
                 STANDARD_RIGHTS_ALL
                 DELETE
                 READ_CONTROL
                 WRITE_DAC
                 WRITE_OWNER
                 SYNCHRONIZE
                 STANDARD_RIGHTS_REQUIRED
                 FILE_GENERIC_READ
                 FILE_GENERIC_WRITE
                 FILE_READ_DATA
                 FILE_WRITE_DATA
                 FILE_APPEND_DATA
                 FILE_READ_EA
                 FILE_WRITE_EA
                 FILE_READ_ATTRIBUTES
                 FILE_WRITE_ATTRIBUTES
 
        Everyone:(OI)(CI)(IO)(special access:)
                             STANDARD_RIGHTS_ALL
                             DELETE
                             READ_CONTROL
                             WRITE_DAC
                             WRITE_OWNER
                             SYNCHRONIZE
                             STANDARD_RIGHTS_REQUIRED
                             FILE_GENERIC_READ
                             FILE_GENERIC_WRITE
                             FILE_READ_DATA
                             FILE_WRITE_DATA
                             FILE_APPEND_DATA
                             FILE_READ_EA
                             FILE_WRITE_EA
                             FILE_READ_ATTRIBUTES
                             FILE_WRITE_ATTRIBUTES
