// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const String BASE_URL = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'http://109.205.183.16:4006/api',
);
const String BASEIMAGEURL = String.fromEnvironment(
  'BASE_IMAGE_URL',
  defaultValue: 'http://109.205.183.16:4004',
);

String LOGIN_URL = '$BASE_URL/Authentication/Login';
String REGISTER_URL = '$BASE_URL/Authentication/CustomerRegister';
String FORGET_PASSWORD_URL = '$BASE_URL/Authentication/ForgotPassword';

String SOCIAL_LOGIN_URL = '$BASE_URL/Authentication/ExternalLogin';
String UPDATE_PROFILE_URL = '$BASE_URL/Account/Profile';
String UPDATE_PROFILE_IMAGE_URL = '$BASE_URL/Account/Profile/ProfilePicture';
String SEND_OTP_URL = '$BASE_URL/Authentication/SendOTP';
String CHECK_OTP_URL = '$BASE_URL/Authentication/CheckOTP';
String CONFIRM_FORGET_PASSWORD =
    '$BASE_URL/Authentication/ConfirmForgotPassword';
String PROFILE_URL = '$BASE_URL/Account/Profile';
String CHANGE_PASSWORD_URL = '$BASE_URL/Account/ChangeUserPassword';
String REFRESH_TOKEN_URL = '$BASE_URL/Authentication/RefreshToken';

String SOCIAL_REGISTER_URL = '$BASE_URL/Authentication/ExternalRegister';
//Core
String COUNTRIES_URL = '$BASE_URL/Countries/list-with-navigation';
String CITIES_URL = '$BASE_URL/Cities/list-with-navigation';
String JOBS_URL = '$BASE_URL/JobTitles/list-with-navigation';
String SKILLS_URL = '$BASE_URL/Skills/list-with-navigation';
String LANGUAGES_URL = '$BASE_URL/Languages/list';
String PRIVATE_SERVICES_URL = '$BASE_URL/Service/list-with-navigation';
String serviceAvailableFiltersUrl(String serviceId) =>
    '$BASE_URL/Service/$serviceId/available-filters';
String CATALOGS_URL = '$BASE_URL/Catalog/worker-filters';
String GETRESUMEWITHID_URL = '$BASE_URL/Catalog/mobile/resumes';
String REQUESTCV_URL = '$BASE_URL/Request/mobile';
String getRequestByIdUrl(String id) => '$BASE_URL/Request/$id';
String CREATE_PRIVATE_RESUME_URL = '$BASE_URL/CV/CreatePrivateResume';

// Stage list
String STAGE_LIST_URL = '$BASE_URL/ServiceFlowStages/list-with-navigation';
String statusLogUrl(String requestId) =>
    '$BASE_URL/RequestStatusLog/listgWithNavigation?RequestId=$requestId';
String contractDataUrl(String requestId) =>
    '$BASE_URL/RequestContractData/by-request/$requestId';
String getLaborLeasingContractsByRequestUrl(String requestId) =>
    '$BASE_URL/labor-leasing/contracts/GetByRequest?laborLeasingRequestId=$requestId';
String getReplacementContractStatusUrl(String requestId) =>
    '$BASE_URL/labor-leasing/replacement-contracts/by-request/$requestId/status';
String get CONFIRM_SIGNED_LABOR_LEASING_CONTRACT_URL =>
    '$BASE_URL/labor-leasing/contracts/Client/confirm-signed';
String get REJECT_READY_NOTIFICATION_URL =>
    '$BASE_URL/labor-leasing/notifications/ready/reject';
String get ACCEPT_READY_NOTIFICATION_URL =>
    '$BASE_URL/labor-leasing/notifications/ready/accept';
String readyNotificationDetailsUrl(String requestId) =>
    '$BASE_URL/labor-leasing/notifications/request/$requestId';
String renewalInfoUrl(String contractId) =>
    '$BASE_URL/labor-leasing/contracts/contracts/$contractId/renewal-info';
String get EXTEND_LABOR_LEASING_CONTRACT_REQUEST_URL =>
    '$BASE_URL/labor-leasing/contracts/extend/request';
String getLeasingRenewalContractsUrl(String requestId) =>
    '$BASE_URL/labor-leasing/contracts/renewals/contracts?RequestId=$requestId';
String get CONFIRM_CLIENT_SIGNED_RENEWAL_CONTRACT_URL =>
    '$BASE_URL/labor-leasing/contracts/renewals/contracts/confirmClientSigned';
String autoSwitchToActiveUrl(String laborLeasingRequestId) =>
    '$BASE_URL/LaborLeasingDelivery/$laborLeasingRequestId/auto-switch-to-active';

// My Orders
String RECRUITMENT_ORDERS_URL = '$BASE_URL/Request/list';
String CONTRACT_LIST_URL = '$BASE_URL/labor-leasing/contracts/client/contracts';
String getContractDetailsByIdUrl(String id) =>
    '$BASE_URL/labor-leasing/contracts/$id';

String SPONSORSHIP_TRANSFER_ORDERS_URL =
    '$BASE_URL/sponsorship-transfer/requests/with-navigation-properties';
String sponsorshipTransferRequestByIdUrl(String id) =>
    '$BASE_URL/sponsorship-transfer/requests/$id/with-navigation-properties';

// Complaints
String ADD_COMPLAINT_URL = '$BASE_URL/ClientComplaint';
String GET_COMPLAINTS_URL = '$BASE_URL/ClientComplaint';
String getComplaintByIdUrl(String id) => '$BASE_URL/Complaints/$id';
String withdrawComplaintUrl(String id) =>
    '$BASE_URL/ClientComplaint/$id/withdraw';
String submitAgainComplaintUrl(String id) =>
    '$BASE_URL/ClientComplaint/$id/submit-again';
String deleteComplaintUrl(String id) => '$BASE_URL/Complaints/$id';
String getComplaintUpdatesUrl(String id) =>
    '$BASE_URL/ComplaintUpdate/GetUpdated/$id';

// Cancellation Request
String cancelRequestUrl(String id) => '$BASE_URL/Request/$id/cancel';

// Request Service Status Actions
String INSERT_VISA_NUMBER_URL =
    '$BASE_URL/RequestServiceStatusActions/insert-visa-number';
String CUSTOMER_CONTRACT_APPROVAL_URL =
    '$BASE_URL/RequestServiceStatusActions/customer-contract-approval';
String CONFIRM_RECEPTION_URL =
    '$BASE_URL/RequestServiceStatusActions/confirm-reception';
String REQUEST_TRIAL_EXTENSION_URL =
    '$BASE_URL/RequestServiceStatusActions/request-trial-extension';

// Transfer of Sponsorship - Cancellation
String SPONSORSHIP_CANCELLATION_URL =
    '$BASE_URL/sponsorship-transfer/cancellation-requests';

// Transfer of Sponsorship - Trial Settlement
String SPONSORSHIP_TRIAL_SETTLEMENT_URL =
    '$BASE_URL/sponsorship-transfer/trial-settlements';

// Transfer of Sponsorship - Trial Extension
String SPONSORSHIP_TRIAL_EXTENSION_URL =
    '$BASE_URL/sponsorship-transfer/trial-extension-requests';

// Transfer of Sponsorship - Remaining Amount
String remainingAmountUrl(String requestId) =>
    '$BASE_URL/sponsorship-transfer/remaining-amount-calculations?RequestId=$requestId';

String trialSettlementUrl(String requestId) =>
    '$BASE_URL/sponsorship-transfer/trial-settlements?RequestId=$requestId';

String govInvoiceUrl(String requestId) =>
    '$BASE_URL/sponsorship-transfer/government-invoices?RequestId=$requestId';

String depositPaymentUrl(String requestId) =>
    '$BASE_URL/sponsorship-transfer/deposit-payments?RequestId=$requestId';

String get DEPOSIT_PAYMENT_NOW_URL =>
    '$BASE_URL/sponsorship-transfer/deposit-payments/now';

String agreementSignaturesUrl(String requestId) =>
    '$BASE_URL/sponsorship-transfer/agreement-signatures?RequestId=$requestId';

String get ELECTRONIC_SIGNATURE_URL =>
    '$BASE_URL/sponsorship-transfer/agreement-signatures/electronicSignature';

// Transfer of Sponsorship
String TRANSFERABLE_WORKERS_URL =
    '$BASE_URL/sponsorship-transfer/transferable-workers/with-navigation-properties';
String transferableWorkerWithNavUrl(String id) =>
    '$BASE_URL/sponsorship-transfer/transferable-workers/$id/with-navigation-properties';
String TRANSFER_SPONSORSHIP_URL =
    '$BASE_URL/sponsorship-transfer/requests/Create/Client';

// Branches
String BRANCHES_URL = '$BASE_URL/branches';

// Labor Leasing
String LABOR_LEASING_PENDING_ORDERS_URL =
    '$BASE_URL/LaborLeasingRequest/Client/Pending';
String LABOR_LEASING_REQUEST_URL = '$BASE_URL/LaborLeasingRequest/Client';
String LABOR_LEASING_SHORT_TERM_REQUEST_URL =
    '$BASE_URL/LaborLeasingRequest/Client/ShortTerm';
String getLaborLeasingRequestByIdUrl(String id) =>
    '$BASE_URL/LaborLeasingRequest/$id';
String laborLeasingWorkflowUrl(String id) =>
    '$BASE_URL/LaborLeasingRequest/$id/workflow';
String LABOR_LEASING_REQUIREMENT_REQUEST_URL =
    '$BASE_URL/LaborLeasingRequestRequirement/requirements';
String LABOR_LEASING_LIST_URL = '$BASE_URL/LaborLeasingService/Client/workers';
String laborLeasingLongTermPackageWorkersUrl(String packageId) =>
    '$BASE_URL/LaborLeasingPackage/Client/long-term/packages/$packageId/workers';
String laborLeasingWorkerByIdUrl(String id, String packageId) =>
    '$BASE_URL/LaborLeasingService/Client/Workers/$id?packageId=$packageId';
String getWorkerByIdUrl(String id) => '$BASE_URL/Worker/$id';
String LABOR_LEASING_PROMOTION_LIST_URL =
    '$BASE_URL/LaborLeasingPromotion/list';
String LABOR_LEASING_PACKAGES_URL =
    '$BASE_URL/LaborLeasingPackage/list-with-navigation';
String LABOR_LEASING_SHORT_TERM_PACKAGES_URL =
    '$BASE_URL/LaborLeasingPackage/Client/short-term/list';
String LABOR_LEASING_LONG_TERM_PACKAGES_URL =
    '$BASE_URL/LaborLeasingPackage/Client/long-term/list';
String LABOR_LEASING_CANCELLATION_REQUEST_URL =
    '$BASE_URL/LaborLeasingCancellationRequest/CancellationRequest';
String LABOR_LEASING_REPLACEMENT_WORKER_REQUEST_URL =
    '$BASE_URL/labor-leasing/replacement-contracts/replacement-request';
String LABOR_LEASING_REPLACEMENT_REASONS_LIST_URL =
    '$BASE_URL/labor-leasing/reasons/list?ReasonType=replacementReason';

// Contact Us
String CONTACT_US_URL = '$BASE_URL/ContactUs';

// Worker Rating
String WORKER_RATING_URL = '$BASE_URL/LaborLeasingWorkerRatings/worker-rating';

// File management
String FILE_UPLOAD_URL = '$BASE_URL/file-management/file-descriptor/upload';
String FILE_LIST_URL = '$BASE_URL/file-management/file-descriptor';
String fileIdUrl(String fileId) =>
    '$BASE_URL/file-management/file-descriptor/content?id=$fileId';
String fileDownloadUrl(String fileId) =>
    '$BASE_URL/file-management/file-descriptor/download/$fileId';
String fileDownloadTokenUrl(String fileId) =>
    '$BASE_URL/file-management/file-descriptor/download/$fileId/token';
