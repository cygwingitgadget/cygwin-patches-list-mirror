Return-Path: <cygwin-patches-return-7476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13339 invoked by alias); 16 Aug 2011 23:39:15 -0000
Received: (qmail 13328 invoked by uid 22791); 16 Aug 2011 23:39:14 -0000
X-SWARE-Spam-Status: Yes, hits=5.3 required=5.0	tests=AWL,BAYES_05,BOTNET,RCVD_IN_DNSWL_NONE,TW_CP,TW_EV,TW_VP
X-Spam-Check-By: sourceware.org
Received: from vms173005pub.verizon.net (HELO vms173005pub.verizon.net) (206.46.173.5)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 16 Aug 2011 23:38:57 +0000
Received: from pool-108-7-2-146.bstnma.east.verizon.net ([unknown] [108.7.2.146]) by vms173005.mailsrvcs.net (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009)) with ESMTPA id <0LQ100351OCSGZO5@vms173005.mailsrvcs.net> for cygwin-patches@cygwin.com; Tue, 16 Aug 2011 18:38:53 -0500 (CDT)
Message-id: <0LQ100354OCSGZO5@vms173005.mailsrvcs.net>
Date: Tue, 16 Aug 2011 23:39:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: [Patch] gethostby_helper
MIME-version: 1.0
Content-type: multipart/mixed; boundary="=====================_1987082843==_"
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
X-SW-Source: 2011-q3/txt/msg00052.txt.bz2


--=====================_1987082843==_
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-length: 3455

This patch has already been already applied.
Diff in attachment and also below.

Pierre

2011-08-16  Pierre Humblet <Pierre.Humblet@ieee.org>

         * net.cc (gethostby_helper): Remove DEBUGGING code from and
         streamline the second pass.

Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.289
diff -u -p -r1.289 net.cc
--- net.cc      4 Aug 2011 08:22:11 -0000       1.289
+++ net.cc      16 Aug 2011 23:31:44 -0000
@@ -1198,57 +1198,34 @@ gethostby_helper (const char *name, cons
    string_ptr = (char *) (ret->h_addr_list + address_count + 1);

    /* Rescan the answers */
-  ancount = alias_count + address_count; /* Valid records */
    alias_count = address_count = 0;
+  prevptr->set_next (prevptr + 1);

-  for (i = 0, curptr = anptr; i < ancount; i++, curptr = curptr->next ())
+  for (curptr = anptr; curptr <= prevptr; curptr = curptr->next ())
      {
        antype = curptr->type;
        if (antype == ns_t_cname)
         {
-         complen = dn_expand (msg, eomsg, curptr->name (), 
string_ptr, string_size);
-#ifdef DEBUGGING
-         if (complen != curptr->complen)
-           goto debugging;
-#endif
+         dn_expand (msg, eomsg, curptr->name (), string_ptr, 
curptr->namelen1);
           ret->h_aliases[alias_count++] = string_ptr;
-         namelen1 = curptr->namelen1;
-         string_ptr += namelen1;
-         string_size -= namelen1;
-         continue;
+         string_ptr += curptr->namelen1;
         }
-      if (antype == type)
+      else
+       {
+         if (address_count == 0)
             {
-             if (address_count == 0)
-               {
-                 complen = dn_expand (msg, eomsg, curptr->name(), 
string_ptr, string_size);
-#ifdef DEBUGGING
-                 if (complen != curptr->complen)
-                   goto debugging;
-#endif
-                 ret->h_name = string_ptr;
-                 namelen1 = curptr->namelen1;
-                 string_ptr += namelen1;
-                 string_size -= namelen1;
-               }
-             ret->h_addr_list[address_count++] = string_ptr;
-             if (addrsize_in != addrsize_out)
-               memcpy4to6 (string_ptr, curptr->data);
-             else
-               memcpy (string_ptr, curptr->data, addrsize_in);
-             string_ptr += addrsize_out;
-             string_size -= addrsize_out;
-             continue;
-           }
-#ifdef DEBUGGING
-      /* Should not get here */
-      goto debugging;
-#endif
+             dn_expand (msg, eomsg, curptr->name (), string_ptr, 
curptr->namelen1);
+             ret->h_name = string_ptr;
+             string_ptr += curptr->namelen1;
+           }
+         ret->h_addr_list[address_count++] = string_ptr;
+         if (addrsize_in != addrsize_out)
+           memcpy4to6 (string_ptr, curptr->data);
+         else
+           memcpy (string_ptr, curptr->data, addrsize_in);
+         string_ptr += addrsize_out;
+       }
      }
-#ifdef DEBUGGING
-  if (string_size < 0)
-    goto debugging;
-#endif

    free (msg);

@@ -1263,16 +1240,6 @@ gethostby_helper (const char *name, cons
       Should it be NO_RECOVERY ? */
    h_errno = TRY_AGAIN;
    return NULL;
-
-
-#ifdef DEBUGGING
- debugging:
-   system_printf ("Please debug.");
-   free (msg);
-   free (ret);
-   h_errno = NO_RECOVERY;
-   return NULL;
-#endif
  }

  /* gethostbyname2: standards? */
--=====================_1987082843==_
Content-Type: application/octet-stream; name="net.cc.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="net.cc.diff"
Content-length: 3835

SW5kZXg6IG5ldC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9uZXQuY2MsdgpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuMjg5CmRpZmYgLXUgLXAgLXIxLjI4OSBuZXQuY2MK
LS0tIG5ldC5jYwk0IEF1ZyAyMDExIDA4OjIyOjExIC0wMDAwCTEuMjg5Cisr
KyBuZXQuY2MJMTYgQXVnIDIwMTEgMjM6MzE6NDQgLTAwMDAKQEAgLTExOTgs
NTcgKzExOTgsMzQgQEAgZ2V0aG9zdGJ5X2hlbHBlciAoY29uc3QgY2hhciAq
bmFtZSwgY29ucwogICBzdHJpbmdfcHRyID0gKGNoYXIgKikgKHJldC0+aF9h
ZGRyX2xpc3QgKyBhZGRyZXNzX2NvdW50ICsgMSk7CiAKICAgLyogUmVzY2Fu
IHRoZSBhbnN3ZXJzICovCi0gIGFuY291bnQgPSBhbGlhc19jb3VudCArIGFk
ZHJlc3NfY291bnQ7IC8qIFZhbGlkIHJlY29yZHMgKi8KICAgYWxpYXNfY291
bnQgPSBhZGRyZXNzX2NvdW50ID0gMDsKKyAgcHJldnB0ci0+c2V0X25leHQg
KHByZXZwdHIgKyAxKTsKIAotICBmb3IgKGkgPSAwLCBjdXJwdHIgPSBhbnB0
cjsgaSA8IGFuY291bnQ7IGkrKywgY3VycHRyID0gY3VycHRyLT5uZXh0ICgp
KQorICBmb3IgKGN1cnB0ciA9IGFucHRyOyBjdXJwdHIgPD0gcHJldnB0cjsg
Y3VycHRyID0gY3VycHRyLT5uZXh0ICgpKQogICAgIHsKICAgICAgIGFudHlw
ZSA9IGN1cnB0ci0+dHlwZTsKICAgICAgIGlmIChhbnR5cGUgPT0gbnNfdF9j
bmFtZSkKIAl7Ci0JICBjb21wbGVuID0gZG5fZXhwYW5kIChtc2csIGVvbXNn
LCBjdXJwdHItPm5hbWUgKCksIHN0cmluZ19wdHIsIHN0cmluZ19zaXplKTsK
LSNpZmRlZiBERUJVR0dJTkcKLQkgIGlmIChjb21wbGVuICE9IGN1cnB0ci0+
Y29tcGxlbikKLQkgICAgZ290byBkZWJ1Z2dpbmc7Ci0jZW5kaWYKKwkgIGRu
X2V4cGFuZCAobXNnLCBlb21zZywgY3VycHRyLT5uYW1lICgpLCBzdHJpbmdf
cHRyLCBjdXJwdHItPm5hbWVsZW4xKTsKIAkgIHJldC0+aF9hbGlhc2VzW2Fs
aWFzX2NvdW50KytdID0gc3RyaW5nX3B0cjsKLQkgIG5hbWVsZW4xID0gY3Vy
cHRyLT5uYW1lbGVuMTsKLQkgIHN0cmluZ19wdHIgKz0gbmFtZWxlbjE7Ci0J
ICBzdHJpbmdfc2l6ZSAtPSBuYW1lbGVuMTsKLQkgIGNvbnRpbnVlOworCSAg
c3RyaW5nX3B0ciArPSBjdXJwdHItPm5hbWVsZW4xOwogCX0KLSAgICAgIGlm
IChhbnR5cGUgPT0gdHlwZSkKKyAgICAgIGVsc2UKKwl7CisJICBpZiAoYWRk
cmVzc19jb3VudCA9PSAwKQogCSAgICB7Ci0JICAgICAgaWYgKGFkZHJlc3Nf
Y291bnQgPT0gMCkKLQkJewotCQkgIGNvbXBsZW4gPSBkbl9leHBhbmQgKG1z
ZywgZW9tc2csIGN1cnB0ci0+bmFtZSgpLCBzdHJpbmdfcHRyLCBzdHJpbmdf
c2l6ZSk7Ci0jaWZkZWYgREVCVUdHSU5HCi0JCSAgaWYgKGNvbXBsZW4gIT0g
Y3VycHRyLT5jb21wbGVuKQotCQkgICAgZ290byBkZWJ1Z2dpbmc7Ci0jZW5k
aWYKLQkJICByZXQtPmhfbmFtZSA9IHN0cmluZ19wdHI7Ci0JCSAgbmFtZWxl
bjEgPSBjdXJwdHItPm5hbWVsZW4xOwotCQkgIHN0cmluZ19wdHIgKz0gbmFt
ZWxlbjE7Ci0JCSAgc3RyaW5nX3NpemUgLT0gbmFtZWxlbjE7Ci0JCX0KLQkg
ICAgICByZXQtPmhfYWRkcl9saXN0W2FkZHJlc3NfY291bnQrK10gPSBzdHJp
bmdfcHRyOwotCSAgICAgIGlmIChhZGRyc2l6ZV9pbiAhPSBhZGRyc2l6ZV9v
dXQpCi0JCW1lbWNweTR0bzYgKHN0cmluZ19wdHIsIGN1cnB0ci0+ZGF0YSk7
Ci0JICAgICAgZWxzZQotCQltZW1jcHkgKHN0cmluZ19wdHIsIGN1cnB0ci0+
ZGF0YSwgYWRkcnNpemVfaW4pOwotCSAgICAgIHN0cmluZ19wdHIgKz0gYWRk
cnNpemVfb3V0OwotCSAgICAgIHN0cmluZ19zaXplIC09IGFkZHJzaXplX291
dDsKLQkgICAgICBjb250aW51ZTsKLQkgICAgfQotI2lmZGVmIERFQlVHR0lO
RwotICAgICAgLyogU2hvdWxkIG5vdCBnZXQgaGVyZSAqLwotICAgICAgZ290
byBkZWJ1Z2dpbmc7Ci0jZW5kaWYKKwkgICAgICBkbl9leHBhbmQgKG1zZywg
ZW9tc2csIGN1cnB0ci0+bmFtZSAoKSwgc3RyaW5nX3B0ciwgY3VycHRyLT5u
YW1lbGVuMSk7CisJICAgICAgcmV0LT5oX25hbWUgPSBzdHJpbmdfcHRyOwor
CSAgICAgIHN0cmluZ19wdHIgKz0gY3VycHRyLT5uYW1lbGVuMTsKKwkgICAg
fQorCSAgcmV0LT5oX2FkZHJfbGlzdFthZGRyZXNzX2NvdW50KytdID0gc3Ry
aW5nX3B0cjsKKwkgIGlmIChhZGRyc2l6ZV9pbiAhPSBhZGRyc2l6ZV9vdXQp
CisJICAgIG1lbWNweTR0bzYgKHN0cmluZ19wdHIsIGN1cnB0ci0+ZGF0YSk7
CisJICBlbHNlCisJICAgIG1lbWNweSAoc3RyaW5nX3B0ciwgY3VycHRyLT5k
YXRhLCBhZGRyc2l6ZV9pbik7CisJICBzdHJpbmdfcHRyICs9IGFkZHJzaXpl
X291dDsKKwl9CiAgICAgfQotI2lmZGVmIERFQlVHR0lORwotICBpZiAoc3Ry
aW5nX3NpemUgPCAwKQotICAgIGdvdG8gZGVidWdnaW5nOwotI2VuZGlmCiAK
ICAgZnJlZSAobXNnKTsKIApAQCAtMTI2MywxNiArMTI0MCw2IEBAIGdldGhv
c3RieV9oZWxwZXIgKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnMKICAgICAgU2hv
dWxkIGl0IGJlIE5PX1JFQ09WRVJZID8gKi8KICAgaF9lcnJubyA9IFRSWV9B
R0FJTjsKICAgcmV0dXJuIE5VTEw7Ci0KLQotI2lmZGVmIERFQlVHR0lORwot
IGRlYnVnZ2luZzoKLSAgIHN5c3RlbV9wcmludGYgKCJQbGVhc2UgZGVidWcu
Iik7Ci0gICBmcmVlIChtc2cpOwotICAgZnJlZSAocmV0KTsKLSAgIGhfZXJy
bm8gPSBOT19SRUNPVkVSWTsKLSAgIHJldHVybiBOVUxMOwotI2VuZGlmCiB9
CiAKIC8qIGdldGhvc3RieW5hbWUyOiBzdGFuZGFyZHM/ICovCg==

--=====================_1987082843==_--
