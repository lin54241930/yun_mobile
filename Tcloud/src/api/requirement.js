import instance from '@/api/index.js'
const urlPrefix = '/v1/'
const RQ_LIST = 'RQ_LIST'
export default {
  addRequirement (params) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/`,
      data: params
    })
  },
  getRequirementList (params) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/`,
      params: params
    })
  },
  cancelRequirementList(){
    instance.cancel(RQ_LIST)
  },
  getRequirementBoard(params) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/board`,
      data: params
    })
  },
  updateBoardStatus(id, params){
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/boardstatus/${id}`,
      data: params
    })
  },
  deleteRequire (id) {
    return instance({
      method: 'delete',
      url: `${urlPrefix}requirement/${id}`
    })
  },
  addComment (id,params){
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/comment/${id}`,
      data: params
    })
  },
  getRequirementLog(id) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/record/detail/${id}`
    })
  },
  editRequirement(params ,id){
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/${id}`,
      data: params
    })
  },
  updateHandler(params ,id){
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/handler/${id}`,
      data: params
    })
  },
  createRequirementReviewRecord (data) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/review`,
      data
    })
  },
  getRequirementReviewList (params) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/review`,
      params
    })
  },
  getRqrmntListByReviewId (reviewId) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/review/${reviewId}`,
    })
  },
  reviewRqrmnt (data, reviewId) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/review/comment/${reviewId}`,
      data})
  },
  // ?????????????????????
  getSubRequireList(params) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/gain/childrequirement`,
      data: params
    })
  },
  // ???????????????
  saveSubItem (params) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/create/childrequirement`,
      data: params
    })
  },
  // ???????????????id?????????????????????
  getDetailById (id) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/${id}`
    })
  },
  // ??????????????????????????????????????????
  changeReviewState (params) {
    return instance({
      method: 'post',
      url: `${urlPrefix}requirement/update/review_status`,
      data: params
    })
  },
  // ???????????????????????????
  getRequirementListNew (params) {
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/list`,
      params: Object.assign(params,{requestId:RQ_LIST})
    })
  },
  getAllRqList(params){
    return instance({
      method: 'get',
      url: `${urlPrefix}requirement/`,
      params:params
    })
  },
  getRequirementCase (id) {
    return instance({
      method: 'get',
      url: `${urlPrefix}case/`,
      params:{requirement_id:id,page_index:1,page_size:10000}
    })
  },
  
}
