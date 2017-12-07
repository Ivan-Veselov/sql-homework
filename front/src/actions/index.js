/**
 * @param rowId is same as id of object that it holds
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get -- TODO -- global enum
 */
export const getQuery = (rowId, getQueryType) => {
    return {
        type: getQueryType,
        rowId
    }
};

/**
 * @param allQueryType same as get, but "all"
 */
export const allQuery = (allQueryType) => {
    return {
        type: allQueryType
    }
};