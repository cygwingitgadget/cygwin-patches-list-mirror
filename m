From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] change to choose.cc in setup.exe for Redownload/Sources crashes
Date: Thu, 17 May 2001 21:14:00 -0000
Message-id: <VA.0000078d.00c73cf1@thesoftwaresource.com>
References: <VA.0000078b.0055922a@thesoftwaresource.com> <20010517233730.A4407@redhat.com>
X-SW-Source: 2001-q2/msg00259.html

Christopher Faylor wrote:
> I hate to say this, but after all of the discussion about indenting,
> the indentation below is obviously wrong.

Buggers, after all that - bitten by the old cut and paste into the email 
editor, and I worked so hard to get it right in vi.

> If (0 <= extra[i].which_is_installed <= TRUST_TEST)

Little too creative -huh.

> I appreciate your tracking this down very much.  

No problem - as soon as I saw the error message and saw the screen I was pretty 
sure I knew what it was.  The more of this I do - the more I learn - so lets 
see what happens this time - hope the changes come through correct this time:

2001-05-07  Brian Keener <bkeener@thesoftwaresource.com>

       * choose.cc (do_choose): Fix incorrect assignment of trust setting
       to use when Redownload or Sources Only selected.        


Index: choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.19
diff -u -p -w -r2.19 choose.cc
--- choose.cc  2001/05/11 02:39:27     2.19
+++ choose.cc  2001/05/18 04:01:33
@@ -1059,7 +1059,11 @@ do_choose (HINSTANCE h)
 
         case TRUST_REDO:
           package[i].action = ACTION_REDO;
-          package[i].trust = extra[i].chooser[extra[i].pick].trust;
+        if ( extra[i].which_is_installed >= 0 
+            && extra[i].which_is_installed <= TRUST_TEST)
+          package[i].trust = extra[i].which_is_installed;
+        else 
+          package[i].trust = TRUST_CURR;
           break;
 
         case TRUST_UNINSTALL:
@@ -1070,7 +1074,11 @@ do_choose (HINSTANCE h)
 
         case TRUST_SRC_ONLY:
           package[i].action = ACTION_SRC_ONLY;
-          package[i].trust = extra[i].chooser[extra[i].pick].trust;
+        if ( extra[i].which_is_installed >= 0 
+            && extra[i].which_is_installed <= TRUST_TEST)
+          package[i].trust = extra[i].which_is_installed;
+        else 
+          package[i].trust = TRUST_CURR;
           package[i].srcaction = SRCACTION_YES;
           break;
 


